# encoding: utf-8

# 预约相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/reservations' do
  before do
    load_api_request_params
  end

  # 门店已预约情况查询
  # params {shop_id: 1}
  # data
=begin
  {
        "shop": {
            "id": 1,
            "name": "东升汽车养护店（石泉路店）",
            "address": "上海市普陀区石泉路22号",
            "contact_name": "李富元",
            "contact_phone": "13917050000",
            "workstation": {
                "lift": 2,
                "normal": 3
            },
            "business_time": {
                "weekend": [
                    {
                        "end": "11:30",
                        "begin": "09:00"
                    },
                    {
                        "end": "18:00",
                        "begin": "13:00"
                    }
                ],
                "not_weekend": [
                    {
                        "end": "11:30",
                        "begin": "09:30"
                    },
                    {
                        "end": "17:00",
                        "begin": "13:00"
                    }
                ]
            }
        },
        "reservations": [
            {
                "order_no": "111",
                "booking_date": "2020-06-07",
                "booking_time_from": "2020-06-07 09:00:00",
                "booking_time_to": "2020-06-07 10:30:00"
            }
        ]
    }
=end
  post "/index", :provides => [:json] do
    api_rescue do
      authenticate
        @shop = Shop.find(@request_params['shop_id'])
        @order_reservations = OrderReservation.where(shop_id: @request_params['shop_id']).where("booking_date >= '#{Time.now.strftime("%F %T")}'")
        { status: 'succ', data: {shop: @shop.to_api, reservations: @order_reservations.map(&:to_api)}}.to_json
    end
  end

  # 订单预约
  # params {shop_id: 1, order_no: "1111", booking_time_from: "2020-06-07 09:00:00", booking_time_to: "2020-06-07 10:30:00"}
  # data
  post "/create", :provides => [:json] do
    api_rescue do
      authenticate
        @shop = Shop.find(@request_params['shop_id'])
        @order = Order.find_by(order_no: @request_params['order_no'])
        ActiveRecord::Base.transaction do
          OrderReservation.create!(shop_id: @shop.id, order_no: @order.order_no, booking_date: Time.parse(@request_params['booking_time_from']).strftime("%F"), booking_time_from: @request_params['booking_time_from'], booking_time_to: @request_params['booking_time_to'])
          @order.update!(status: "appointed")
          @order.sub_orders.where(sub_type: "install").update_all(status: "appointed")
        end
        { status: 'succ', data: {}}.to_json
    end
  end
end
