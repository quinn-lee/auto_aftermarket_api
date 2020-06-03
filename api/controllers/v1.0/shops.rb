# encoding: utf-8

# 商家相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/shops' do
  before do
    load_api_request_params
  end

  # 返回商家下的所有门店信息
  # params 无
  # data [{"id": 1, "name": "东升汽车养护店（石泉路店）","address": "上海市普陀区石泉路22号","contact_name": "李富元","contact_phone": "13917050000","workstation": null,"business_time": null}...]

  post "/", :provides => [:json] do
    api_rescue do
      authenticate
      @shops = Shop.where(merchant_id: @merchant.id)

      { status: 'succ', data: @shops.map(&:to_api)}.to_json
    end
  end

  # 根据shop_id查询门店
  # params {shop_id: 1}
  # data
=begin
  {
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
    }
=end
  post "/show", :provides => [:json] do
    api_rescue do
      authenticate
      @shop = Shop.find(@request_params['shop_id'])

      { status: 'succ', data: @shop.to_api}.to_json
    end
  end
end
