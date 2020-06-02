# encoding: utf-8

# 订单相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/orders' do
  before do
    load_api_request_params
  end

  # 创建订单并调用微信预支付
  # params
=begin
  {
    "shop_id": 2,
    "contact_info": {"name": "李富元", "mobile": "13917050000"},
    "amount": 200,
    "pay_amount": 200,
    "order_type": "maintenance", # maintenance->维修保养，purchase->商城自选商品
    "items": [
        {
          "name": "大保养推荐套餐",
          skus: [
            {
              "sku_id": 1,
              "quantity": 1,
              "price": 55
            },
            {
              "sku_id": 2,
              "quantity": 1,
              "price": 55
            }
          ]
        },
        {
          "name": "自选项目",
          skus: [
            {
              "sku_id": 3,
              "quantity": 1,
              "price": 45
            }
          ]
        }
      ]
  }
=end
  # data {"prepay_id"=>"aaa", "amount"=>"", "order_no"=> ""}
  post "/create", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        @order = Order.new
        @order.customer_id = @customer.id
        @order.merchant_id = @merchant.id
        @order.order_date = Time.now
        @order.order_no = @order.gen_order_no
        @order.amount = @request_params['amount']
        @order.order_type = @request_params['order_type']
        @order.pay_amount = @request_params['pay_amount']
        @order.status = "unpaid"
        @order.shop_id = @request_params['shop_id']
        @order.delivery_info = Shop.find(@request_params['shop_id']).to_api_simple
        @order.contact_info = @request_params['contact_info']

        @order.save!
        @request_params['items'].each do |item|
          item['skus'].each do |sku|
            OrderSku.create!(order_no: @order.order_no, name: item['name'], t_sku_id: sku['sku_id'], quantity: sku['quantity'], price: sku['price'] )
          end
        end
      end
      ActiveRecord::Base.transaction do
        pay_res = Wxpay.pre_pay(@merchant, @order.order_no, @customer.openid, (BigDecimal.new(@order.pay_amount.to_s)*100).to_i, env['REMOTE_HOST'])
        if pay_res["status"]=="succ"
          @wi=WxpayInfo.create!({
            prepay_id: pay_res["info"]["prepay_id"],
            customer_id: @customer.id,
            order_no: @order.order_no,
            amount: @order.pay_amount,
            expired_time: Time.now+1.hour
          })
        else
          raise "prepay_id产生失败:#{pay_res["info"]["err_msg"]}"
        end
      end

      { status: 'succ', data: {"prepay_id"=>@wi.prepay_id, "amount"=>@order.pay_amount, "order_no"=> @order.order_no}}.to_json
    end
  end

  # 订单列表
  # params {"status": "unpaid"(待付款)/"paid"(待收货)/"received"(待预约)/"appointed"(待安装)}
  # data
=begin
  [
    {
      id: 1,
      order_date: "2020-05-29",
      order_no: "12423434",
      amount: 349,
      status: "paid",
      delivery_info: {
        name: "aaa",
        address: "bbb",
        contact_name: "aaa",
        contact_phone: "ccc"
      },
      contact_info: {
        name: "李富元",
        mobile: "13917050000"
      },
      items: [
        {
          name: "推荐保养套餐",
          skus: [
            {
              order_no: "12423434",
              quantity: 1,
              price: 49,
              id: 2,
              sku_name: "美孚",
              sku_code: "aaaaaa",
              pics: ["images/260811002.jpg", "images/1336270541.jpg"]
            }
          ]
        }
      ]
    }
  ]
=end
  post "/index", :provides => [:json] do
    api_rescue do
      authenticate

      @orders = Order.where(customer_id: @customer.id)
      @orders.where(status: @request_params['status']) if @request_params['status'].present?
      { status: 'succ', data: @orders.map(&:to_api)}.to_json
    end
  end

  # 订单详情
  # params {"id": 4}
  # data
=begin
    {
      id: 1,
      order_date: "2020-05-29",
      order_no: "12423434",
      amount: 349,
      status: "paid",
      delivery_info: {
        name: "aaa",
        address: "bbb",
        contact_name: "aaa",
        contact_phone: "ccc"
      },
      contact_info: {
        name: "李富元",
        mobile: "13917050000"
      },
      items: [
        {
          name: "推荐保养套餐",
          skus: [
            {
              order_no: "12423434",
              quantity: 1,
              price: 49,
              id: 2,
              sku_name: "美孚",
              sku_code: "aaaaaa",
              pics: ["images/260811002.jpg", "images/1336270541.jpg"]
            }
          ]
        }
      ]
    }
=end
  post "/show", :provides => [:json] do
    api_rescue do
      authenticate

      @order = Order.find(@request_params["id"])
      { status: 'succ', data: @order.to_api}.to_json
    end
  end

  # 微信支付异步通知
  post :notify do
    logger.info("into notify")
    begin
      request.body.rewind
      if (body=request.body.read).present?
        logger.info("body: [#{body}]")
        doc = Nokogiri::Slop body
        xbuilder = Builder::XmlMarkup.new(:target => ret_xml="")
        if doc.xml.return_code.content =="SUCCESS"
          #1.校验签名
          if check_sign(doc, Merchant.first)==true
            order_no=doc.xml.out_trade_no.content
            ActiveRecord::Base.transaction do
              wi=WxpayInfo.lock.where(order_no:out_trade_no).last
              if wi.present?
                #2.校验返回的订单金额是否与商户侧的订单金额一致
                if wi.amount*100==(doc.xml.total_fee.content).to_i
                  wi.transaction_id=doc.xml.transaction_id.content#微信支付订单号
                  wi.pay_time=Time.parse(doc.xml.time_end.content) if doc.xml.time_end.present?
                  wi.pay_detail=pay_detail_transfer(doc, Merchant.first)
                  wi.status="paid"
                  wi.save!
                  xbuilder.xml{
                    xbuilder.return_code "SUCCESS"
                  }
                  wi.after_paid
                else
                  logger.info("notify: Inconsistency of amount!!! ")
                  xbuilder.xml{
                    xbuilder.return_code "FAIL"
                    xbuilder.return_msg "Inconsistency of amount"
                  }
                end
              else
                logger.info("WxpayInfo not found")
                xbuilder.xml{
                  xbuilder.return_code "SUCCESS"
                }
              end
            end
          else
            logger.info("Sign Check Wrong")
            xbuilder.xml{
              xbuilder.return_code "FAIL"
              xbuilder.return_msg "签名失败"
            }
          end

        end

        logger.info("ret [#{ret_xml}]")
        render plain: ret_xml and return
      end
    rescue=> e
      logger.info("wxpay_redirect rescue: #{e.message}")
    end
  end
end
