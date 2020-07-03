AutoAftermarketApi::Admin.controllers :orders do
  before do
    set_orders_title_and_local
  end

  # 订单列表
  get :index do
    @orders = current_account.merchant.orders
    @orders = @orders.where(status: params[:status]) if params[:status].present?
    @orders = @orders.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'orders/index'
  end
end
