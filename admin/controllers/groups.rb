AutoAftermarketApi::Admin.controllers :groups do
  before do
    set_groups_title_and_local
  end

  # 选择sku
  get :select_sku do
    @spus = current_account.merchant.t_spus
    @categories = TCategory.all
    @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
    @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
    @spus = @spus.where("title like '%#{params[:title]}%'") if params[:title].present?
    @spus = @spus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'groups/select_sku'
  end

  # 新建拼团
  get :new do
    @sku = TSku.find(params[:sku_id])
    @group = Group.new(t_sku_id: @sku.id, merchant_id: current_account.merchant.id)
    render 'groups/new'
  end

  # 新建拼团
  post :create do
    begin
      @group = Group.new(params[:group])
      @sku = TSku.find(@group.t_sku_id)
      @group.created_by = current_account.id
      @group.status = 0
      @group.sku_info = {t_spu_id: @sku.t_spu_id, title: @sku.title, t_category_id: @sku.t_spu.t_category_id}
      if @group.save
        flash.now[:success] = "创建拼团活动成功"
        redirect(url(:groups, :select_sku))
      else
        raise "创建拼团活动失败"
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      render 'groups/new'
    end
  end

end
