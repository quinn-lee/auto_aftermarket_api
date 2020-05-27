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
  # data {current: "奥迪A4L 2019款 45 TFSI quattro个性运动版 国V"}
  post :add_car, :provides => [:json] do
    api_rescue do
      authenticate

      @car_model = CarModel.find(@request_params["model_id"])
      ActiveRecord::Base.transaction do
        Car.where(customer_id: @customer.id).update_all(is_current: false)
        @current_car = Car.create!(customer_id: @customer.id, car_model_id: @car_model.id, car_model_name: "#{@car_model.car_model_name} #{@car_model.car_model_version}", is_current: true)
      end
      { status: 'succ', data: {current: @current_car.car_model_name}}.to_json
    end
  end

  # 客户所有车型
  # params 空
  # data [{"id": 1,"car_model_id": 1,"car_model_name": "奥迪A4L 2020款 35 TFSI 时尚动感型","is_current": false}...]
  post :cars, :provides => [:json] do
    api_rescue do
      authenticate

      @cars = Car.where(customer_id: @customer.id)
      { status: 'succ', data: @cars.map(&:to_api)}.to_json
    end
  end

  # 修改当前车型
  # params {"car_id": 2}
  # data {current: "奥迪A4L 2019款 45 TFSI quattro个性运动版 国V"}
  post :change_car, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        Car.where(customer_id: @customer.id).update_all(is_current: false)
        @car = Car.find(@request_params["car_id"])
        @car.update!(is_current: true)
      end
      { status: 'succ', data: {current: @car.car_model_name}}.to_json
    end
  end
end
