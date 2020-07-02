AutoAftermarketApi::Admin.controllers :seckills do
  before do
    set_seckills_title_and_local
  end

  # 新建秒杀
  get :new do
    @sku = TSku.find(params[:sku_id])
    @seckill = Seckill.new(t_sku_id: @sku.id, merchant_id: current_account.merchant.id)
    render 'seckills/new'
  end

  # 新建秒杀
  post :create do
    begin
      @seckill = Seckill.new(params[:seckill])
      @sku = TSku.find(@seckill.t_sku_id)
      @seckill.created_by = current_account.id
      @seckill.status = 1
      @seckill.remaining_num = @seckill.num
      @seckill.sku_info = {t_spu_id: @sku.t_spu_id, title: @sku.title, t_category_id: @sku.t_spu.t_category_id}
      if @seckill.save
        flash[:success] = "创建秒杀活动成功"
        redirect(url(:seckills, :index))
      else
        raise "创建秒杀活动失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'seckills/new'
    end
  end

  get :index do
    @seckills = current_account.merchant.seckills
    @seckills = @seckills.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'seckills/index'
  end

  get :change_status, :with => :id do
    begin
      @seckill = Seckill.find(params[:id])
      @seckill.update!(status: params[:status])
      flash[:notice] = "修改状态成功"
      redirect(url(:seckills, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:seckills, :index))
    end
  end

  get :edit, :with => :id do
    @seckill = Seckill.find(params[:id])
    render 'seckills/edit'
  end

  post :update, :with => :id do
    begin
      @seckill = Seckill.find(params[:id])
      raise "该秒杀不可修改" if @seckill.status != 1 # 上架的秒杀才可编辑
      raise "该秒杀已开始购买，不可修改价格" if @seckill.seckill_buyers.purchased.count > 0 && @seckill.seckill_price != BigDecimal.new(params[:seckill][:seckill_price])
      @seckill.update!(params[:seckill])
      flash[:notice] = "秒杀信息修改成功"
      redirect(url(:seckills, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'seckills/edit'
    end
  end

  get :show, :with => :id do
    @seckill = Seckill.find(params[:id])
    render 'seckills/show'
  end

end
