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
    "items": [
        {
          "name": "大保养推荐套餐",
          skus: [
            {
              "sku_code": "BBBBB",
              "quantity": 1,
              "price": 55
            },
            {
              "sku_code": "CCCCC",
              "quantity": 1,
              "price": 55
            }
          ]
        },
        {
          "name": "自选项目",
          skus: [
            {
              "sku_code": "AAAAA",
              "quantity": 1,
              "price": 45
            }
          ]
        }
      ]
  }
=end
  # data {"prepay_id"=>"aaa", "amount"=>"", "order_num"=> ""}
  post "/create", :provides => [:json] do
    api_rescue do
      authenticate


      { status: 'succ', data: {"prepay_id"=>"aaa", "amount"=>"", "order_num"=> ""}}.to_json
    end
  end

  # 订单列表
  # params {"status": "unpaid"(待付款)/"paid"(待预约)/"appointed"(待安装)}
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

      @orders = Order.all
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
end
