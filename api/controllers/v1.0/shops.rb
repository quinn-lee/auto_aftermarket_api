# encoding: utf-8

# 用户登录 用户汽车相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/shops' do
  before do
    load_api_request_params
  end

  # 返回商家下的所有门店信息
  # params 无
  # data [{"id": 1, "name": "东升汽车养护店（石泉路店）","address": "上海市普陀区石泉路22号","contact_name": "李富元","contact_phone": "13917050000","workstation": null,"business_time": null}...]
  # 此处获得的token，需要在后续请求中加入到header中，key='token', value='token值'
  post "/", :provides => [:json] do
    api_rescue do
      authenticate
      @shops = Shop.where(merchant_id: @merchant.id)

      { status: 'succ', data: @shops.map(&:to_api)}.to_json
    end
  end
end
