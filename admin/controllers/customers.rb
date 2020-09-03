AutoAftermarketApi::Admin.controllers :customers do
  before do
    set_customers_title_and_local
  end

  get :index do
    @customers = current_account.merchant.customers
    @customers = @customers.where(role_id: params[:role_id]) if params[:role_id].present?
    @customers = @customers.where("wechat_info->>'nickName' like '%#{params[:nickname]}%'") if params[:nickname].present?
    @customers = @customers.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'customers/index'
  end

  get :agents do
    @title = "分销员审核"
    @customers = current_account.merchant.customers.where(app_status: 0)
    @customers = @customers.order("updated_at desc").paginate(page: params[:page], per_page: 30)
    render 'customers/agents'
  end

  get :check_agent, :with => :id do
    begin
      @customer = Customer.find(params[:id])
      raise "请选择角色" if params[:status] == '1' && params[:role_id].blank?
      @customer.update(app_status: params[:status], role_id: params[:role_id])
      flash[:notice] = "审核成功"
      redirect(url(:customers, :agents))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:customers, :agents))
    end
  end
end
