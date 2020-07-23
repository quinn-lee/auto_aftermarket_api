AutoAftermarketApi::Admin.controllers :customers do
  before do
    set_customers_title_and_local
  end

  get :agents do
    @title = "分销员审核"
    @local = "分销员审核"
    @customers = Customer.where(role_id: [1,2])
    @customers = @customers.order("app_status asc").order("updated_at desc").paginate(page: params[:page], per_page: 30)
    render 'customers/agents'
  end

  get :check_agent, :with => :id do
    @customer = Customer.find(params[:id])
    @customer.update(app_status: params[:status])
    flash[:notice] = "审核成功"
    redirect(url(:customers, :agents))
  end
end
