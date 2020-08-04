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
    @orders = @orders.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'orders/index'
  end

  # 采购列表
  get :purchases do
    @order_skus = OrderSku.where("lack_quantity > 0").where("(SELECT orders.merchant_id FROM orders WHERE orders.order_no = order_skus.order_no) = #{current_account.merchant.id}")
    @order_skus = @order_skus.where(order_no: params[:order_no]) if params[:order_no].present?
    @order_skus = @order_skus.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'orders/purchases'
  end

  # 待发货列表
  get :deliveries do
    @orders = current_account.merchant.orders.where(status: 'received').where("(SELECT sub_orders.sub_type FROM sub_orders WHERE orders.id = sub_orders.order_id) = 'delivery'")
    @orders = @orders.where(order_no: params[:order_no]) if params[:order_no].present?
    @orders = @orders.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'orders/deliveries'
  end

  # 取消
  get :cancel, :with => :id do
    begin
      @order = Order.find(params[:id])
      @order.update!(status: "cancelled", cancel_time: Time.now)
      flash[:success] = "取消成功"
      redirect(url(:orders, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :index))
    end
  end

  # 取消
  get :done, :with => :id do
    begin
      @order = Order.find(params[:id])
      @order.update!(status: "done")
      flash[:success] = "订单状态修改成功"
      redirect(url(:orders, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :index))
    end
  end

  # 采购完成操作
  get :purchased do
    begin
      raise "请勾选需要操作的记录" if params[:ids].blank?
      @order_skus = OrderSku.where(id: params[:ids])
      ActiveRecord::Base.transaction do
        @order_skus.each do |order_sku|
          sku = TSku.find(order_sku.t_sku_id)
          # 更新库存数量
          sku.update!(stock_num: (sku.stock_num||0)+order_sku.lack_quantity, available_num: (sku.available_num||0)+order_sku.lack_quantity)
          # 更新需采购数量
          order_sku.update!(lack_quantity: 0)
          order = Order.find_by(order_no: order_sku.order_no)
          if OrderSku.where(order_no: order.order_no).where("lack_quantity > 0").count == 0
            # 更新订单状态
            order.update!(status: "received")
          end
        end
      end
      flash[:success] = "操作成功"
      redirect(url(:orders, :purchases))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :purchases))
    end
  end

  # 发货完成
  get :delivered do
    begin
      raise "请勾选需要操作的记录" if params[:ids].blank?
      @orders = Order.where(id: params[:ids])
      @orders.update_all(status: "delivered", delivere_time: Time.now)
      SubOrder.where(sub_type: "delivery").where(order_id: params[:ids]).update(status: "delivered")
      flash[:success] = e.message
      redirect(url(:orders, :deliveries))
    rescue => e
      logger.info e.backtrace
      flash[:error] = "操作成功"
      redirect(url(:orders, :deliveries))
    end
  end
end
