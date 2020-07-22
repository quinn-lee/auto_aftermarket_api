# encoding: utf-8

# 佣金提现相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0/withdraws' do
  before do
    load_api_request_params
  end

  # 佣金提现申请
  # params {"apply_amount": 10}
  # data 空
  post :apply, :provides => [:json] do
    api_rescue do
      authenticate
      #TODO
      percent = 0.1
      raise "提现金额不能为空" if @request_params['apply_amount'].blank?
      raise "提现金额不能大于可提现金额" if BigDecimal.new(@request_params['apply_amount'].to_s) > @customer.can_withdraw_money(@merchant, percent)
      Withdraw.create!(customer_id: @customer.id, merchant_id: @merchant.id, app_date: Time.now, amount: BigDecimal.new(@request_params['apply_amount'].to_s), status: 0)
      { status: 'succ', data: {}}.to_json
    end
  end

  # 佣金提现记录
  # params 空
  # data
=begin
  [
        {
            "app_date": "2020-07-23 00:37:12",
            "amount": "40.0",
            "status": 0  # 0代表申请中待打款，1代表已打款
        }
    ]
=end
  post :index, :provides => [:json] do
    api_rescue do
      authenticate

      @wds = Withdraw.where(customer_id: @customer.id, merchant_id: @merchant.id).order("app_date desc")

      { status: 'succ', data: @wds.map(&:to_api)}.to_json
    end
  end
end
