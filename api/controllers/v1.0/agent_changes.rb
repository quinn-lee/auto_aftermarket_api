# encoding: utf-8

# 收件地址相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/agent_changes' do
  before do
    load_api_request_params
  end

  # 申请更换分销员
  # params {"content": "申请更换专属客户为xxx"}
  # data 空
  post "/apply", :provides => [:json] do
    api_rescue do
      authenticate
      raise "申请内容不能为空" if @request_params['content'].blank?
      AgentChange.create!(customer_id: @customer.id, merchant_id: @merchant.id, content: @request_params['content'], status: 0)
      { status: 'succ', data: {}}.to_json
    end
  end

end
