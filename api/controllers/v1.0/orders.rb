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
    "shop_id": 2, # 到店安装时，选择的门店，自选商品时如果没有到店安装的，该项为空
    "contact_info": {"name": "李富元", "mobile": "13917050000"}, # 到店安装时需要填写，
    "delivery_info": {"province": "", "city": "", "district": "", "address": "",
                        "name": "", "mobile": ""}, # 寄送地址 自选商品时 如果有寄送到家的商品时需要填写
    "amount": 300,  #订单实际金额
    "pay_amount": 200,   #支付金额 = 订单实际金额 - 优惠券金额
    "coupon_amount": 100,   #优惠券金额，未使用优惠券时该项为空
    "coupon_receive_id": 1,  #使用的已领取优惠券ID，每个订单只能使用一张优惠券，未使用优惠券时该项为空
    "group_id": 1,  #团购活动ID, order_type=group时，该项必须填写
    "seckill_id": 1,  #秒杀活动ID, order_type=seckill时，该项必须填写
    "order_type": "maintenance", # maintenance->维修保养，purchase->商城自选商品，group->团购，seckill->秒杀
    "items": [
        {
          "name": "大保养推荐套餐",
          skus: [
            {
              "sku_id": 1,
              "quantity": 1,
              "price": 55,
              "service": {"到店安装": 50} # 自选商品时选择的可选服务，如果没有可选服务项，则该字段为空
            },
            {
              "sku_id": 2,
              "quantity": 1,
              "price": 55,
              "service": {"无需安装": 0} # 自选商品时选择的可选服务，如果没有可选服务项，则该字段为空
            }
          ]
        },
        {
          "name": "自选项目",
          skus: [
            {
              "sku_id": 3,
              "quantity": 1,
              "price": 45,
              "service": {}
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
        raise "order_type #{@request_params['order_type']} wrong" unless (['maintenance', 'purchase'].include? @request_params['order_type'])
        if @request_params['order_type'] == "maintenance"
          unless @shop = Shop.find(@request_params['shop_id'])
            raise "shop not exists"
          end
          raise "contact_info can not be null" if @request_params['contact_info'].blank?
        end
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
        if @request_params['order_type'] == "maintenance" # 维修保养
          @order.delivery_info = @shop.to_api_simple
          @order.contact_info = @request_params['contact_info']
        elsif (["purchase", "group", "seckill"].include? @request_params['order_type']) # 自选商品、团购、秒杀
          @order.delivery_info = @request_params['delivery_info']
          @order.contact_info = @request_params['contact_info'].present? ? @request_params['contact_info'] : @request_params['delivery_info']
        end

        @order.save!
        if @request_params['order_type'] == "group" # 团购商品
          group = Group.find(@request_params['group_id'])
          raise "该团购状态为不可购买" if group.status != 1
          raise "该团已过期，无法购买" if group.end_time < Time.now
          raise "已超过最大成团人数，无法购买" if group.group_buyers.purchased.count >= group.max_num
          # 记录购买者
          GroupBuyer.create!(customer_id: @customer.id, group_id: group.id, order_id: @order.id, t_sku_id: group.t_sku_id, group_quantity: 1, status: 1, group_price: group.group_price, group_amount: group.group_amount)
        elsif @request_params['order_type'] == "seckill" # 秒杀商品
          seckill = Seckill.find(@request_params['seckill_id'])
          raise "该秒杀状态为不可购买" if seckill.status != 1
          raise "该秒杀已过期，无法购买" if seckill.end_time < Time.now
          raise "该秒杀无剩余商品，无法购买" if seckill.remaining_num < 1
          # 修改剩余可秒杀商品数
          seckill.update!(remaining_num: seckill.remaining_num-1)
        end
        if @request_params['coupon_receive_id'].present? #使用优惠券
          cr = CouponReceive.find(@request_params['coupon_receive_id'])
          raise "该优惠券已使用或已过期，无法使用" if cr.status != 0
          raise "该优惠券已过期，无法使用" if cr.coupon.end_time < Time.now
          cr.update!(status: 1) # 修改领取的优惠券状态为已使用
          # 记录使用的优惠券
          CouponLog.create!(customer_id: @customer.id, coupon_receive_id: cr.id, order_id: @order.id, order_original_amount: @order.amount, coupon_amount: cr.coupon_money, order_final_amount: @order.pay_amount, status: 0)
        end
        @request_params['items'].each do |item|
          item['skus'].each do |sku|
            tsku = TSku.find(sku['sku_id'])
            raise "商品库存不足，创建订单失败" if tsku.available_num < sku['quantity']
            tsku.update(stock_num: (tsku.stock_num||0)-sku['quantity'].to_i, available_num: (tsku.available_num||0)-sku['quantity'].to_i)
            OrderSku.create!(order_no: @order.order_no, name: item['name'], t_sku_id: sku['sku_id'], quantity: sku['quantity'], price: sku['price'], service_fee: sku['service'] )
          end
        end
      end
      ActiveRecord::Base.transaction do
        if BigDecimal.new(@order.pay_amount.to_s) < BigDecimal.new("0.0001")
          @wi=WxpayInfo.create!({
            customer_id: @customer.id,
            order_no: @order.order_no,
            amount: @order.pay_amount,
            expired_time: Time.now+1.hour
          })
          @wi.after_paid
        else
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
      end

      { status: 'succ', data: {"prepay_id"=>@wi.prepay_id, "amount"=>@order.pay_amount, "order_no"=> @order.order_no}}.to_json
    end
  end

  # 未支付订单 继续支付 调用微信预支付
  # params {“order_id”=>1}
  # data {"prepay_id"=>"aaa", "amount"=>"", "order_no"=> ""}
  post "/pay", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        @order = Order.find(@request_params['order_id'])
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

  # 订单删除
  # params {"order_id"=>1}
  # data {"}
  post "/delete", :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        @order = Order.find(@request_params['order_id'])
        raise "can not delete status=#{@order.status}" unless @order.can_delete?
        @order.update!(status: "delete")
      end

      { status: 'succ', data: {}}.to_json
    end
  end

  # 订单列表
  # params {"status": "unpaid"(待付款)/"paid"(待收货)/"received"(待预约)/"appointed"(待安装)/"done"(已完成)/"delete"(已删除)}
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
      need_hours: 1.5,
      need_lift_hours: 0.5,
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
      ],
      "sub_orders": [
                {
                    "sub_type": "install",
                    "shop_info": {
                        "id": 1,
                        "name": "东升汽车养护店（石泉路店）",
                        "address": "上海市普陀区石泉路22号",
                        "contact_name": "李富元",
                        "contact_phone": "13917050000"
                    },
                    "delivery_info": {
                        "id": 1,
                        "name": "东升汽车养护店（石泉路店）",
                        "address": "上海市普陀区石泉路22号",
                        "contact_name": "李富元",
                        "contact_phone": "13917050000"
                    },
                    "items": [
                        {
                            "id": 5,
                            "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                            "sku_code": "AN01224235",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 1,
                            "price": "559.0"
                        },
                        {
                            "id": 6,
                            "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                            "sku_code": "AN01224236",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 1,
                            "price": "159.0"
                        },
                        {
                            "id": 7,
                            "title": "马勒/MAHLE 机油滤清器 OC1480",
                            "sku_code": "AN01224241",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 1,
                            "price": "329.0"
                        },
                        {
                            "id": 3,
                            "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
                            "sku_code": "AN01224233",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 2,
                            "price": "329.0"
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

      @orders = Order.where(customer_id: @customer.id).where.not(status: "delete").order("created_at desc")
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
      need_hours: 1.5,
      need_lift_hours: 0.5,
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
      ],
      "sub_orders": [
                {
                    "sub_type": "install",
                    "shop_info": {
                        "id": 1,
                        "name": "东升汽车养护店（石泉路店）",
                        "address": "上海市普陀区石泉路22号",
                        "contact_name": "李富元",
                        "contact_phone": "13917050000"
                    },
                    "delivery_info": {
                        "id": 1,
                        "name": "东升汽车养护店（石泉路店）",
                        "address": "上海市普陀区石泉路22号",
                        "contact_name": "李富元",
                        "contact_phone": "13917050000"
                    },
                    "items": [
                        {
                            "id": 5,
                            "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （4L装）",
                            "sku_code": "AN01224235",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 1,
                            "price": "559.0"
                        },
                        {
                            "id": 6,
                            "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 0W-20 SN级 （1L装）",
                            "sku_code": "AN01224236",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 1,
                            "price": "159.0"
                        },
                        {
                            "id": 7,
                            "title": "马勒/MAHLE 机油滤清器 OC1480",
                            "sku_code": "AN01224241",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 1,
                            "price": "329.0"
                        },
                        {
                            "id": 3,
                            "title": "【正品授权】美孚/Mobil 美孚1号全合成机油 5W-40 SN级 （4L装）",
                            "sku_code": "AN01224233",
                            "images": [
                                "images/260811002.jpg",
                                "images/1336270541.jpg"
                            ],
                            "order_no": "100000001520200608020209",
                            "service_fee": null,
                            "quantity": 2,
                            "price": "329.0"
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
              wi=WxpayInfo.lock.where(order_no:out_trade_no).order(:id => :asc).last
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
