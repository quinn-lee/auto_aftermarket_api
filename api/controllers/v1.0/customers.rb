# encoding: utf-8

# 用户登录 用户汽车相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/customers' do
  before do
    load_api_request_params
  end

  # 注册或登录
  # params {"code": "011EewQl0V6Juq13KWNl01SgQl0EewQ-", "dist_share_id": 10}
  # dist_share_id 为分享记录的id，只有在新用户注册的时候需要传输（通过点击别人分享的内容进入小程序时 ）
  # data {"token": ""}
  # 此处获得的token，需要在后续请求中加入到header中，key='token', value='token值'
  post "/", :provides => [:json] do
    api_rescue do
      code,body=WebFunctions.method_url_call("get","https://api.weixin.qq.com/sns/jscode2session?appid=#{Settings.wechat.appId}&secret=#{Settings.wechat.appSecret}&js_code=#{@request_params["code"]}&grant_type=authorization_code",{},"JSON")
      if code!="200"
        logger.info("call api weixin expection , [#{code}]")
        raise "call api weixin timeout,please try again"
      else
        res=JSON.parse body
        if res["errcode"].present?
          raise res['errmsg']
        else
          unless @cus = Customer.find_by(openid: res['openid'])
            dist_agent_id = nil
            dist_share_id = @request_params["dist_share_id"]
            if @request_params["dist_share_id"].present?
              agent = DistShare.agent(@request_params["dist_share_id"]) #根据分享链，找出最近邻的分销员或找出最早分享客户
              dist_agent_id = agent.id #记录新用户归属
            end
            @cus = Customer.create(dist_share_id: dist_share_id, dist_agent_id: dist_agent_id, openid: res['openid'], unionid: res['unionid'], token: "#{Digest::MD5.hexdigest(res['openid'])}#{RandomCode.generate_token}")
          end
        end
      end

      { status: 'succ', data: {token: @cus.token}}.to_json
    end
  end

  # 新增车型
  # params {"model_id": 4} 车款id
  # data {"id": 1,"car_model_id": 1,"car_model_name": "奥迪A4L 2020款 35 TFSI 时尚动感型", "mileage": 9000,"is_current": false, "license_date": "", "color": "白色"}
  post :add_car, :provides => [:json] do
    api_rescue do
      authenticate

      @car_model = CarModel.find(@request_params["model_id"])
      ActiveRecord::Base.transaction do
        Car.where(customer_id: @customer.id).update_all(is_current: false)
        @current_car = Car.create!(customer_id: @customer.id, car_model_id: @car_model.id, car_model_name: "#{@car_model.car_model_name} #{@car_model.car_model_version}", is_current: true)
      end
      { status: 'succ', data: @current_car.to_api}.to_json
    end
  end

  # 客户所有车型
  # params 空
  # data [{"id": 1,"car_model_id": 1,"car_model_name": "奥迪A4L 2020款 35 TFSI 时尚动感型", "mileage": 9000,"is_current": false, "license_date": "", "color": "白色", "brand": "奥迪","brand_image_url": "http://image.bitautoimg.com/bt/car/default/images/logo/masterbrand/png/100/m_9_100.png"}...]
  post :cars, :provides => [:json] do
    api_rescue do
      authenticate

      @cars = Car.where(customer_id: @customer.id).order(:id => :asc)
      { status: 'succ', data: @cars.map(&:to_api)}.to_json
    end
  end

  # 修改当前车型
  # params {"car_id": 2}
  # data {"id": 1,"car_model_id": 1,"car_model_name": "奥迪A4L 2020款 35 TFSI 时尚动感型", "mileage": 9000,"is_current": false, "license_date": "", "color": "白色"}
  post :change_car, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        Car.where(customer_id: @customer.id).update_all(is_current: false)
        @car = Car.find(@request_params["car_id"])
        @car.update!(is_current: true)
      end
      { status: 'succ', data: @car.to_api}.to_json
    end
  end

  # 修改车型当前里程数
  # params {"car_id": 2, "mileage": 9000, "license_date": "2019-01-01", "color": "黑色"}
  # data {"id": 1,"car_model_id": 1,"car_model_name": "奥迪A4L 2020款 35 TFSI 时尚动感型", "mileage": 9000,"is_current": false, "license_date": "", "color": "白色"}
  post :edit_car, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        @car = Car.find(@request_params["car_id"])
        mileage_his = @car.mileage_his || []
        mileage_his << {mileage:  @car.mileage, date: Time.now.strftime("%F")} if @car.mileage.present?
        @car.update!(mileage_his: mileage_his, mileage: @request_params["mileage"], license_date: @request_params["license_date"], color: @request_params["color"])
      end
      { status: 'succ', data: @car.to_api}.to_json
    end
  end


  # 记录微信用户信息
  # params: {
      # avatarUrl: "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwG"...
      # city: "Taizhou"
      # country: "China"
      # gender: 1
      # language: "zh_CN"
      # nickName: "nonki"
      # province: "Zhejiang"
  # }
  # data {}
  post :wechat_info, :provides => [:json] do
    api_rescue do
      authenticate
      @customer.wechat_info = @request_params
      @customer.save!

      { status: 'succ', data: {}}.to_json
    end
  end

  # 记录微信用户信息
  # params: {
      # accuracy: 65
      # errMsg: "getLocation:ok"
      # horizontalAccuracy: 65
      # latitude: 31.2494
      # longitude: 121.397
      # speed: -1
      # verticalAccuracy: 65
  # }
  # data {}
  post :location_info, :provides => [:json] do
    api_rescue do
      authenticate
      his_location = @customer.his_location_info || []
      his_location << @request_params
      @customer.his_location_info = his_location
      @customer.location_info = @request_params
      @customer.save!

      { status: 'succ', data: {}}.to_json
    end
  end

  # 用户分享
  # params: {
      # url: '/pages/index/index',
      # options: { 分享人token: '1233', 参数1: 'a', 参数2: 'b' }
  # }
  post :share, :provides => [:json] do
    api_rescue do
      authenticate
      Share.create!(customer_id: @customer.id, url: @request_params['url'], options: @request_params['options'])
      { status: 'succ', data: {}}.to_json
    end
  end

  # pv记录
  # params: {pv: [
    # { timestamp: '2020-06-22 11:11:11', url: '/pages/commodities/show?spu_id=7' },
    # { timestamp: '2020-06-22 12:12:12', url: '/pages/index/index' }
  # ]
  #}
  post :page_views, :provides => [:json] do
    api_rescue do
      authenticate
      ActiveRecord::Base.transaction do
        @request_params['pv'].each do |pv|
          PageView.create!(customer_id: @customer.id, visit_time: pv['timestamp'], url: pv['url'])
        end
      end
      { status: 'succ', data: {}}.to_json
    end
  end

  # 返回客户的商品访问记录(最近100条)
  # params 空
  # data
  post :recent_sku_views, :provides => [:json] do
    api_rescue do
      authenticate

      @svs = @customer.sku_views.order("visit_time desc")
      { status: 'succ', data: @svs.limit(100).map{|sv| sv.t_sku.to_api}}.to_json
    end
  end

  # 判断客户是否符合申请成为分销员的条件
  # params 空
  # data {can_agent: true} true为符合申请条件，false为不符合申请条件
  post :can_agent, :provides => [:json] do
    api_rescue do
      authenticate
      { status: 'succ', data: {can_agent: @customer.can_dist_apply?}}.to_json
    end
  end

  # 申请成为销售员/分销员
  # params {'role': 1}
  # role 1=>销售员 2=>分销员
  # 公司内部员工申请成为销售员（可直接申请，无需判断），客户申请成为分销员（需要先调用can_agent接口判断能否申请），
  # 后台审核通过后才能访问商户版小程序
  # data 空
  post :agent_apply, :provides => [:json] do
    api_rescue do
      authenticate
      raise "已经是分销员或销售员了" if [1, 2].include? @customer.role_id
      raise "角色错误" unless [1, 2].include? @request_params['role'].to_i
      raise "不符合申请条件" unless @customer.can_dist_apply?
      @customer.update!(role_id: @request_params['role'].to_i, app_status: 0)
      { status: 'succ', data: {}}.to_json
    end
  end

  # 商户版小程序登录
  # params {"code": "011EewQl0V6Juq13KWNl01SgQl0EewQ-"}
  # data {"token": ""}
  # 此处获得的token，需要在后续请求中加入到header中，key='token', value='token值'
  post :agent_login, :provides => [:json] do
    api_rescue do
      code,body=WebFunctions.method_url_call("get","https://api.weixin.qq.com/sns/jscode2session?appid=#{Settings.wechat.appId}&secret=#{Settings.wechat.appSecret}&js_code=#{@request_params["code"]}&grant_type=authorization_code",{},"JSON")
      if code!="200"
        logger.info("call api weixin expection , [#{code}]")
        raise "call api weixin timeout,please try again"
      else
        res=JSON.parse body
        if res["errcode"].present?
          raise res['errmsg']
        else
          # 后台审核通过后的分销员或销售员才能访问商户版小程序
          unless cus = Customer.find_by(openid: res['openid'], role_id: [1, 2], app_status: 1)
            raise "权限错误"
          end
        end
      end

      { status: 'succ', data: {token: cus.token}}.to_json
    end
  end

  # 销售员/分销员 个人资料修改
  # params {"name": "a", "mobile": "1330001102", "email": "lifuyuan@hotmail.com", wx_barcode: "Base64编码后的串", avatar: "Base64编码后的串"}
  # data 空
  post :modify_agent_info, :provides => [:json] do
    api_rescue do
      authenticate
      @customer.name = @request_params['name'] if @request_params['name'].present?
      @customer.mobile = @request_params['mobile'] if @request_params['mobile'].present?
      @customer.email = @request_params['email'] if @request_params['email'].present?
      if @request_params['wx_barcode'].present? # 保存微信二维码
        file_path = "public/uploads/tmp/wx_barcode#{@customer.id}#{Time.now.strftime('%Y%m%d%H%M%S')}"
        decode_base64_content = Base64.decode64(@request_params['wx_barcode'])
        File.delete(file_path) if File.exists?(file_path)
        File.open(file_path, "wb"){|f| f.write decode_base64_content}
        File.open(file_path, "rb"){|f| @customer.wx_barcode = f }
      end
      if @request_params['avatar'].present? # 保存头像
        file_path = "public/uploads/tmp/avatar#{@customer.id}#{Time.now.strftime('%Y%m%d%H%M%S')}"
        decode_base64_content = Base64.decode64(@request_params['avatar'])
        File.delete(file_path) if File.exists?(file_path)
        File.open(file_path, "wb"){|f| f.write decode_base64_content}
        File.open(file_path, "rb"){|f| @customer.avatar = f }
      end
      @customer.save!
      { status: 'succ', data: {}}.to_json
    end
  end

  # 销售员/分销员 资料
  # params 空
  # data
=begin
  {
        "id": 1,
        "name": "a",
        "mobile": "1330001102",
        "token": "",
        "email": "lifuyuan@hotmail.com",
        "wx_barcode": "/uploads/customer/wx_barcode/1/wx_barcode120200722222956",
        "avatar": "/uploads/customer/avatar/1/avatar120200722222956",
        "wechat_info": {
            "city": "Taizhou",
            "gender": 1,
            "country": "China",
            "language": "zh_CN",
            "nickName": "nonki",
            "province": "Zhejiang",
            "avatarUrl": "https://wx.qlogo.cn/mmopen/vi_32/Q0j4TwG"
        }
    }
=end
  post :agent_info, :provides => [:json] do
    api_rescue do
      authenticate
      { status: 'succ', data: @customer.to_agent_api}.to_json
    end
  end
end
