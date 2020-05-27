AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/customers' do
  before do
    load_api_request_params
  end

  # 注册或登录
  # params {"code": "011EewQl0V6Juq13KWNl01SgQl0EewQ-"}
  # data {"token": ""}
  # 此处获得的token，需要在后续请求中加入到header中，key='token', value='token值'
  post "/", :provides => [:json] do
    api_rescue do
      code,body=method_url_call("get","https://api.weixin.qq.com/sns/jscode2session?appid=#{Settings.wechat.appId}&secret=#{Settings.wechat.appSecret}&js_code=#{@request_params["code"]}&grant_type=authorization_code",{},"JSON")
      if code!="200"
        logger.info("call api weixin expection , [#{code}]")
        raise "call api weixin timeout,please try again"
      else
        res=JSON.parse body
        if res["errcode"].present?
          raise res['errmsg']
        else
          unless cus = Customer.find_by(openid: res['openid'])
            cus = Customer.create(openid: res['openid'], unionid: res['unionid'], token: "#{Digest::MD5.hexdigest(res['openid'])}#{generate_token}")
          end
        end
      end

      { status: 'succ', data: {token: cus.token}}.to_json
    end
  end

  # 新增车型
  # params {"model_id": 4} 车款id
  # data {current: ""}
  post :add_car, :provides => [:json] do
    api_rescue do
      authenticate

      @car_model = CarModel.find(@request_params["model_id"])
      @current_car = Car.create!(customer_id: @customer.id, car_model_id: @car_model.id, car_model_name: "#{@car_model.car_model_name} #{@car_model.car_model_version}", is_current: true)
      { status: 'succ', data: {current: @current_car.car_model_name}}.to_json
    end
  end
end
