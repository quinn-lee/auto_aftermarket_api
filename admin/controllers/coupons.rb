AutoAftermarketApi::Admin.controllers :coupons do
  before do
    set_coupons_title_and_local
  end

  # 新建优惠券
  get :new do
    @coupon = Coupon.new(merchant_id: current_account.merchant.id)
    render 'coupons/new'
  end

  # 新建优惠券
  post :create do
    begin
      @coupon = Coupon.new(params[:coupon])
      @coupon.created_by = current_account.id
      @coupon.status = 1
      if @coupon.save
        flash[:success] = "创建优惠券成功"
        redirect(url(:coupons, :index))
      else
        logger.info @coupon.errors.messages
        raise "创建优惠券失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'coupons/new'
    end
  end

  # 优惠券列表
  get :index do
    @coupons = current_account.merchant.coupons
    @coupons = @coupons.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'coupons/index'
  end

  # 修改状态
  get :change_status, :with => :id do
    begin
      @coupon = Coupon.find(params[:id])
      @coupon.update!(status: params[:status])
      flash[:notice] = "修改状态成功"
      redirect(url(:coupons, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:coupons, :index))
    end
  end

  # 编辑优惠券
  get :edit, :with => :id do
    @coupon = Coupon.find(params[:id])
    render 'coupons/edit'
  end

  # 修改优惠券
  post :update, :with => :id do
    begin
      @coupon = Coupon.find(params[:id])
      raise "该优惠券不可修改" if @coupon.status != 1 # 上架的秒杀才可编辑
      raise "该优惠券已经有人领取过，不可修改" if @coupon.coupon_receives.count > 0
      @coupon.update!(params[:coupon])
      flash[:notice] = "优惠券信息修改成功"
      redirect(url(:coupons, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'coupons/edit'
    end
  end

  # 选择sku
  get :select_spu, :with => :id do
    @coupon = Coupon.find(params[:id])
    @spus = current_account.merchant.t_spus
    @categories = TCategory.all
    @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
    @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
    @spus = @spus.where("title like '%#{params[:title]}%'") if params[:title].present?
    @spus = @spus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'coupons/select_spu'
  end

  post :update_spu, :with => :id do
    begin
      @coupon = Coupon.find(params[:id])
      raise "该优惠券不可修改" if @coupon.status != 1 # 上架的秒杀才可编辑
      raise "该优惠券已经有人领取过，不可修改" if @coupon.coupon_receives.count > 0
      @coupon.update!(spus: params[:ids])
      flash[:notice] = "指定商品成功"
      redirect(url(:coupons, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      @spus = current_account.merchant.t_spus
      @categories = TCategory.all
      @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
      @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
      @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
      @spus = @spus.where("title like '%#{params[:title]}%'") if params[:title].present?
      @spus = @spus.order("created_at asc").paginate(page: params[:page], per_page: 30)
      render 'coupons/select_spu'
    end
  end

end
