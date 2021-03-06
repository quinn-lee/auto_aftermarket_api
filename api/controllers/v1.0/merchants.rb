# encoding: utf-8

# 商户信息相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/merchants' do
  before do
    load_api_request_params
  end

  # 商户信息
  # params 空
  # data {"contact_mobile": "13917050484","customer_wechat_no": "adfadf", "share_image": "/uploads/merchant/share_image/1/Screenshot_20201009_103248.png"}
  post :info, :provides => [:json] do
    api_rescue do
      authenticate
      { status: 'succ', data: {contact_mobile: @merchant.contact_mobile, customer_wechat_no: @merchant.customer_wechat_no, share_image: @merchant.share_image.try{|si| si.url}}}.to_json
    end
  end

end
