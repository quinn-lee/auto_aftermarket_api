AutoAftermarketApi::Admin.controllers :orders do
  before do
    set_orders_title_and_local
  end

  # 订单列表
  get :index do
    @orders = current_account.merchant.orders
    @orders = @orders.where(account_id: params[:customer_id]) if params[:customer_id].present?
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

  # 新增分销信息
  get :new_dist_order, :with => :id do
    @order = Order.find(params[:id])
    @dist_roles = DistRole.all
    @dist_order = DistOrder.new(order_id: @order.id, merchant_id: @order.merchant_id, account_id: @order.account_id)
    render 'orders/new_dist_order'
  end

  # 新增分销信息
  post :create_dist_order, :with => :id do
    begin
      logger.info params
      @order = Order.find(params[:id])
      @dist_roles = DistRole.all
      @dist_order = DistOrder.new(params[:dist_order])
      raise "请选择分销角色" if params[:dist_role_id].blank?
      raise "请选择参与分销员" if params[:dist_order][:dist_agent_id].blank?
      raise "请填写分销金额" if params[:dist_order][:pay_amount].blank?
      dist_role = DistRole.find(params[:dist_role_id])
      t_sku = TSku.where(id: @order.order_skus.map(&:t_sku_id)).first
      percent = dist_role.dist_percent
      commission = BigDecimal.new(sprintf("%.2f", (params[:dist_order][:pay_amount].to_f * percent/100).to_s))
      @dist_order.dist_percent = percent
      @dist_order.dist_type = dist_role.name
      @dist_order.sku_info = t_sku.t_spu.t_category.name
      @dist_order.commission = commission
      @dist_order.pay_time = @order.pay_time
      @dist_order.complete_time = @order.updated_at if @order.status == 'done'
      @dist_order.save!
      flash[:success] = "新增参与分销员成功"
      redirect(url(:orders, :show, :id=>@order.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'orders/new_dist_order'
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

  # 到店安装预约时间表 gantt
  get :reservations_gantt do
    @current_week = Time.parse(params[:date]) rescue Time.now.beginning_of_week
    @current_date = Time.parse(params[:date]) rescue Time.now.beginning_of_day

    if params[:remote] == 'true'
      query = Order.joins(:sub_orders).joins('LEFT JOIN order_reservations on order_reservations.order_no = orders.order_no').
        where.not('orders.status' => %w[unpaid appointing done delete cancelling cancelled]).
        where('sub_orders.sub_type' => 'install', 'sub_orders.status' => 'appointed')
      @result = {
        # title: '到店安装预约时间表',
        # subtitle: @current_date.strftime('%F'),
        date: @current_date.to_i * 1000,
        xAxis: { min: (@current_date + 8.hours).to_i * 1000 ,max: (@current_date + 24.hours).to_i * 1000 },
        data: []
      }
      orders = query.where('order_reservations.booking_date' => @current_date).
        select('orders.order_no, orders.contact_info, order_reservations.booking_time_from AS booking_time_from, order_reservations.booking_time_to AS booking_time_to')

      orders.sort_by{|order| order[:start]}.each_with_index do |order, index|
        @result[:data] << {
          id: order.order_no,
          parent: 'total',
          name: "订单#{index + 1}",
          start: order.booking_time_from.to_i * 1000,
          end: order.booking_time_to.to_i * 1000,
          contact_name: (order.contact_info['name'] rescue nil),
          contact_mobile: (order.contact_info['mobile'] rescue nil)
        }
      end
      # @result[:data].sort_by!{|order| order[:start] }
      @result[:data] << { id: 'total', name: "#{orders.length}个订单", collapsed: true }
      @result.to_json
    else
      render :reservations_gantt
    end
  end

  # 到店安装预约时间表 calendar
  get :reservations_calendar do
    if params[:remote] == 'true'
      start_date = Time.parse(params[:start]) rescue Time.now.beginning_of_month
      end_date = Time.parse(params[:end]) rescue start_date + 1.month
      # 调色盘
      palette = %w[#e91e63 #59e0c5 #FF5370 #f3c30b #1f2e86 #0D4CFF #AA00FF #FF5722]

      query = Order.joins(:sub_orders).joins('LEFT JOIN order_reservations on order_reservations.order_no = orders.order_no').
        where.not('orders.status' => %w[unpaid appointing done delete cancelling cancelled]).
        where('sub_orders.sub_type' => 'install', 'sub_orders.status' => 'appointed')
      orders = query.where('order_reservations.booking_date BETWEEN ? AND ?', start_date, end_date).
        select('orders.id, orders.order_no, orders.contact_info, order_reservations.booking_time_from AS booking_time_from, order_reservations.booking_time_to AS booking_time_to')

      @result = []
      orders.each do |order|
        name   = order.contact_info['name'] rescue nil
        mobile = order.contact_info['mobile'] rescue nil
        @result << {
          title: "#{name}, #{mobile}, 订单号: #{order.order_no}",
          start: order.booking_time_from.strftime('%F %T'),
          end: order.booking_time_to.strftime('%F %T'),
          color: palette[order.id % palette.length],
          url: url(:orders, :show, :id => order.id)
        }
      end
      @result.to_json
    else
      render :reservations_calendar
    end
  end

  # 修改地址
  get :edit_address, :with => :id do
    @order = Order.find(params[:id])
    render 'orders/edit_address'
  end

  post :update_address, :with => :id do
    begin
      @order = Order.find(params[:id])
      raise "地址信息不能为空" if params[:province].blank? or params[:city].blank? or params[:address].blank? or params[:name].blank? or params[:mobile].blank?
      delivery_info = {province: params[:province], city: params[:city], district: params[:district], address: params[:address], name: params[:name], mobile: params[:mobile]}
      @order.update!(delivery_info: delivery_info)
      flash[:success] = "地址修改成功"
      redirect(url(:orders, :show, :id=>@order.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render "orders/edit_address"
    end
  end

  get :change_skus, :with => :id do
    @order = Order.find(params[:id])
    @sku = TSku.find(params[:sku_id])
    @order_sku_id = params[:order_sku_id]
    @order_sku = OrderSku.find(params[:order_sku_id])
    render 'orders/change_skus'
  end

  get :update_skus, :with => :id do
    begin
      @order = Order.find(params[:id])
      @sku = TSku.find(params[:sku_id])
      @order_sku_id = params[:order_sku_id]
      @new_sku = TSku.find(params[:new_sku_id])
      @order_sku = OrderSku.find(params[:order_sku_id])
      ActiveRecord::Base.transaction do
        raise "商品库存不足，商品替换失败" if @new_sku.available_num < @order_sku.quantity
        lack_quantity = @order_sku.quantity - (@new_sku.stock_num < 0 ? 0 : @new_sku.stock_num) # 需采购的数量
        lack_quantity = lack_quantity < 0 ? 0 : lack_quantity
        @new_sku.update!(stock_num: (@new_sku.stock_num||0)-@order_sku.quantity, available_num: (@new_sku.available_num||0)-@order_sku.quantity)
        @sku.update!(stock_num: (@sku.stock_num||0)+@order_sku.quantity, available_num: (@sku.available_num||0)+@order_sku.quantity)
        @order_sku.update!(t_sku_id: @new_sku.id, price: @new_sku.price, lack_quantity: lack_quantity)
      end
      flash[:success] = "商品替换成功"
      redirect(url(:orders, :show, :id=>@order.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'orders/change_skus'
    end
  end




end
