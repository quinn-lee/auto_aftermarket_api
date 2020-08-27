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
    @orders = @orders.where("delivery_info->>'name' like '%#{params[:rcpt_name]}%'") if params[:rcpt_name].present?
    @orders = @orders.where("delivery_info->>'mobile' like '%#{params[:rcpt_phone]}%'") if params[:rcpt_phone].present?
    @orders = @orders.where("contact_info->>'name' like '%#{params[:contact_name]}%'") if params[:contact_name].present?
    @orders = @orders.where("contact_info->>'mobile' like '%#{params[:contact_phone]}%'") if params[:contact_phone].present?
    @orders = @orders.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'orders/index'
  end

  # 订单详情
  get :show, :with => :id do
    begin
      @order = Order.find(params[:id])
      render 'orders/show'
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :index))
    end
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
    # 根据子订单状态查询待发货列表
    # @orders = current_account.merchant.orders.where("(SELECT sub_orders.sub_type FROM sub_orders WHERE orders.id = sub_orders.order_id) = 'delivery'").where("(SELECT sub_orders.status FROM sub_orders WHERE orders.id = sub_orders.order_id) = 'received'")
    @orders = current_account.merchant.orders.joins(:sub_orders).where('sub_orders.sub_type' => 'delivery', 'sub_orders.status' => 'received')
    @orders = @orders.where('orders.order_no' => params[:order_no].strip) if params[:order_no].present?
    @orders = @orders.distinct.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'orders/deliveries'
  end

  # 取消
  get :cancel, :with => :id do
    begin
      @order = Order.find(params[:id])
      @order.do_cancel
      flash[:success] = "取消成功"
      redirect(url(:orders, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :index))
    end
  end

  # 完成
  get :done, :with => :id do
    begin
      @order = Order.find(params[:id])
      @order.update!(status: "done")
      @order.sub_orders.update_all(status: "done")
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
            order.sub_orders.where(sub_type: "delivery").update_all(status: "received")
            if order.sub_orders.where(sub_type: "install").present?
              order.update!(status: "appointing") #更新为待预约
              order.appoint_subscribe #订阅消息
              order.sub_orders.where(sub_type: "install").update_all(status: "appointing")
            end
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
  post :delivered, :with => :id do
    begin
      @order = Order.find(params[:id])
      raise "单号不能为空" if params[:shpmt_num].blank?
      raise "物流商不能为空" if params[:logi_company].blank?
      logi_info = {shpmt_num: params[:shpmt_num], logi_company: params[:logi_company]}
      status = (@order.status == "received" ? "delivered" : @order.status)
      @order.update(status: status, delivere_time: Time.now, delivery_info: (@order.delivery_info||{}).merge(logi_info))
      @order.sub_orders.where(sub_type: "delivery").update_all(status: "delivered")
      @order.delivery_subscribe
      flash[:success] = "操作成功"
      redirect(url(:orders, :deliveries))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :deliveries))
    end
  end

  # 取消审核列表
  get :cancelling do
    @orders = current_account.merchant.orders
    @orders = @orders.where(status: "cancelling")
    @orders = @orders.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'orders/cancelling'
  end

  # 取消审核
  get :cancel_check, :with => :id do
    begin
      @order = Order.find(params[:id])
      if params[:status] == 'cancelled'
        @order.do_cancel
      else
        @order.do_cancel_reject
      end
      flash[:success] = "操作成功"
      redirect(url(:orders, :cancelling))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :cancelling))
    end
  end
end
