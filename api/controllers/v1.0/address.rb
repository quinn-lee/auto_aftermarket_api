# encoding: utf-8

# 收件地址相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/address' do
  before do
    load_api_request_params
  end

  # 新增客户地址
  # params {"city"=>"北京市", "name"=>"test", "mobile"=>"13800138000", "address"=>"xxx", "district"=>"东城区", "province"=>"北京市"}
  # data 空
  post "/create", :provides => [:json] do
    api_rescue do
      authenticate
      Address.create!(customer_id: @customer.id, province: @request_params['province'], city: @request_params['city'], district: @request_params['district'], address: @request_params['address'], name: @request_params['name'], mobile: @request_params['mobile'])
      { status: 'succ', data: {}}.to_json
    end
  end

  # 修改客户地址
  # params {"id": 1, "city"=>"北京市", "name"=>"test", "mobile"=>"13800138000", "address"=>"xxx", "district"=>"东城区", "province"=>"北京市"}
  # data 空
  post "/update", :provides => [:json] do
    api_rescue do
      authenticate
      @address = Address.find(@request_params['id'])
      @address.update!(customer_id: @customer.id, province: @request_params['province'], city: @request_params['city'], district: @request_params['district'], address: @request_params['address'], name: @request_params['name'], mobile: @request_params['mobile'])
      { status: 'succ', data: {}}.to_json
    end
  end

  # 删除客户地址
  # params {"id": 1}
  # data 空
  post "/delete", :provides => [:json] do
    api_rescue do
      authenticate
      @address = Address.find(@request_params['id'])
      @address.destroy
      { status: 'succ', data: {}}.to_json
    end
  end

  # 查询客户地址
  # params 空
  # data [{"id": 2,"city"=>"北京市", "name"=>"test", "mobile"=>"13800138000", "address"=>"xxx", "district"=>"东城区", "province"=>"北京市"},{}]
  post "/index", :provides => [:json] do
    api_rescue do
      authenticate
      @address = Address.where(customer_id: @customer.id)

      { status: 'succ', data: @address.map(&:to_api)}.to_json
    end
  end
end
