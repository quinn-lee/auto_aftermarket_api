AutoAftermarketApi::Admin.controllers :withdraws do
  before do
    set_withdraws_title_and_local
  end

  get :index do
    @withdraws = Withdraw.where(merchant_id: current_account.merchant.id)
    @withdraws = @withdraws.order("status asc").order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'withdraws/index'
  end

  get :audit, :with => :id do
    @withdraw = Withdraw.find(params[:id])
    @withdraw.update(status: 1, pay_date: Time.now)
    flash[:notice] = "状态修改成功"
    redirect(url(:withdraws, :index))
  end
end
