AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0' do
  before do
    load_api_request_params
  end

  # 注册或登录
  # params {"code": "011EewQl0V6Juq13KWNl01SgQl0EewQ-"}
  # data {"token": ""}
  post :customers, :provides => [:json] do
    api_rescue do
      # authenticate_access_token

      code,body=method_url_call("get","https://api.weixin.qq.com/sns/jscode2session?appid=wxb5ebd7edf0437cdb&secret=986dfb559ebb15402628db871ba6f608&js_code=#{@request_params["code"]}&grant_type=authorization_code",{},"JSON")
      if code!="200"
        logger.info("call api weixin expection , [#{code}]")
        raise "call api weixin timeout,please try again"
      else
        res=JSON.parse body
        if res["errcode"].present?
          raise res['errmsg']
        else
          unless cus = Customer.find_by(openid: res['openid'])
            cus = Customer.create(openid: res['openid'], unionid: res['unionid'], token: generate_token)
          end
        end
      end

      { status: 'succ', data: {token: cus.token}}.to_json
    end
  end
end
