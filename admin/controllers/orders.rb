AutoAftermarketApi::Admin.controllers :orders do
  before do
    set_orders_title_and_local
  end

  # 订单列表
  get :index do
    @orders = current_account.merchant.orders
    @orders = @orders.where(status: params[:status]) if params[:status].present?
    @orders = @orders.where(order_type: params[:order_type]) if params[:order_type].present?
    @orders = @orders.where(order_no: params[:order_no]) if params[:order_no].present?
    @orders = @orders.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'orders/index'
  end

  # 采购列表
  get :purchases do
    @order_skus = OrderSku.where("lack_quantity > 0").where("(SELECT orders.merchant_id FROM orders WHERE orders.order_no = order_skus.order_no) = #{current_account.merchant.id}")
    @order_skus = @order_skus.where(order_no: params[:order_no]) if params[:order_no].present?
    @order_skus = @order_skus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'orders/purchases'
  end
end
