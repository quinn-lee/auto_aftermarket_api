AutoAftermarketApi::Admin.controllers :orders do
  before do
    set_orders_title_and_local
  end

  # 订单列表
  get :index do
    @orders = current_account.merchant.orders
    @orders = @orders.where(customer_id: params[:customer_id]) if params[:customer_id].present?
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
      raise "退款金额必须填写" if params[:refund_amount].blank?
      @order.do_cancel(params[:refund_amount])
      flash[:success] = "取消成功"
      redirect(url(:orders, :show, :id=>@order.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :show, :id=>@order.id))
    end
  end

  # 修改订单金额
  get :update_pay_amount, :with => :id do
    begin
      @order = Order.find(params[:id])
      raise "支付金额必须填写" if params[:pay_amount].blank?
      raise "该订单不能修改支付金额" if @order.status != 'unpaid'
      @order.update(old_pay_amount: (@order.old_pay_amount || @order.pay_amount), pay_amount: params[:pay_amount])
      flash[:success] = "支付金额修改成功"
      redirect(url(:orders, :show, :id=>@order.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :show, :id=>@order.id))
    end
  end

  # 完成
  get :done, :with => :id do
    begin
      @order = Order.find(params[:id])
      @order.update!(status: "done")
      @order.sub_orders.update_all(status: "done")
      flash[:success] = "订单状态修改成功"
      redirect(url(:orders, :show, :id=>@order.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :show, :id=>@order.id))
    end
  end

  # 采购完成操作
  get :purchased do
    begin
      raise "请勾选需要操作的记录" if params[:ids].blank?
      @order_skus = OrderSku.where(id: params[:ids])
      book = Spreadsheet::Workbook.new
      sheet1 = book.create_worksheet
      sheet1.row(0).concat %w{商品名称 商品规格 SKU代码 订单号	需采购数量}
      format = Spreadsheet::Format.new :color => :blue,:weight => :bold,:size => 12
      sheet1.row(0).default_format = format
      sheet1.row(0).height = 18
      i = 1
      @order_skus.each do |order_sku|
        sheet1.row(i).replace [
            order_sku.t_sku.title,
            order_sku.t_sku.sale_attrs_desc,
            order_sku.t_sku.sku_code,
            order_sku.order_no,
            order_sku.lack_quantity
        ]
        i += 1
      end
      dir_path = "public/uploads/tmp/purchases/"
      Dir.mkdir dir_path unless Dir.exist? dir_path
      file_path = "#{dir_path}/#{current_account.id}_#{Time.now.strftime("%Y%m%d%H%M")}_purchases.xls"
      book.write file_path
      send_file(file_path,:type => 'charset=utf-8; header=present',:filename => "purchases_export.xls", :disposition =>'attachment', :encoding => 'gb2312')

    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :purchases))
    end
  end

  # 采购完成操作
  get :delivery_export do
    begin
      raise "请勾选需要操作的记录" if params[:ids].blank?
      @orders = Order.where(id: params[:ids])
      pdf = CombinePDF.new
      @orders.each{|order| OrderBuilder.new.build(order); pdf << CombinePDF.load(order.order_file_path);}
      dir_path = "public/uploads/tmp/orders/"
      Dir.mkdir dir_path unless Dir.exist? dir_path
      file_path = "#{dir_path}/#{current_account.id}_#{Time.now.strftime("%Y%m%d%H%M")}_order.pdf"
      pdf.save file_path
      send_file(file_path,:type => 'charset=utf-8; header=present',:filename => "order_export.pdf", :disposition =>'attachment', :encoding => 'gb2312')

    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :deliveries))
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
        raise "退款金额必须填写" if params[:refund_amount].blank?
        @order.do_cancel(params[:refund_amount])
      else
        raise "审核不通过原因必须填写" if params[:reject_reason].blank?
        @order.do_cancel_reject(params[:reject_reason])
      end
      flash[:success] = "操作成功"
      redirect(url(:orders, :cancelling))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:orders, :cancelling))
    end
  end

  # 到店安装预约时间表
  get :reservations do
    query = Order.joins(:sub_orders).joins('LEFT JOIN order_reservations on order_reservations.order_no = orders.order_no').
      where.not('orders.status' => %w[unpaid appointing done delete cancelling cancelled]).
      where('sub_orders.sub_type' => 'install', 'sub_orders.status' => 'appointed')

    @current_week = Time.parse(params[:date_from]) rescue Time.now.beginning_of_week  # 按周统计, 设定初始日
    @date_axis = []  # 日期轴
    @result = {}  # 页面呈现数据
    (8..20).each do |i|
      tag = "#{sprintf('%02d', i)}:00~#{sprintf('%02d', i+1)}:00"
      @result[tag] = []
    end
    weekdays = %w[一 二 三 四 五 六 日]
    7.times do |d|
      date = @current_week + d.days
      is_today = date.today?
      @date_axis << { date: date.strftime('%F'), wday: weekdays[date.wday - 1], today: is_today }
      orders = query.where('order_reservations.booking_date' => date).
        select('orders.order_no, orders.contact_info, order_reservations.booking_time_from AS booking_time_from')  # 按日读取数据

      # 按日初始化数据格式
      @result.each do |key, val|
        val[d] ||= {}
        val[d][:today] = is_today
        val[d][:data] ||= []
      end
      # 按小时分配数据
      orders.each do |order|
        h = order.booking_time_from.hour
        if (8..20).include? h
          tag = "#{sprintf('%02d', h)}:00~#{sprintf('%02d', h+1)}:00"
          @result[tag][d][:data] << {
            order_no: order.order_no,
            name: (order.contact_info['name'] rescue nil),
            mobile: (order.contact_info['mobile'] rescue nil)
          }
        else
          # 超过预约时间范围的数据处理, 待定
        end
      end
    end
    render 'orders/reservations'
  end
end
