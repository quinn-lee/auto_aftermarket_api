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
        flash.now[:success] = "创建秒杀活动成功"
        redirect(url(:groups, :select_sku, :from => "seckills"))
      else
        raise "创建秒杀活动失败"
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      render 'seckills/new'
    end
  end

end
