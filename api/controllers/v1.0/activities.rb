# encoding: utf-8

# 营销活动相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/activities' do
  before do
    load_api_request_params
  end

  # 查询营销活动
  # params 空
  # data []
  post "/", :provides => [:json] do
    api_rescue do
      authenticate
      @activities = @merchant.activities

      { status: 'succ', data: @activities.map(&:to_api)}.to_json
    end
  end

end
