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
    @from = params[:from].present? ? params[:from].to_s.to_sym : :groups
    @mod = @from == :groups ? "拼团" : "秒杀"
    @title = @from == :groups ? "拼团" : "秒杀"
    @local = @from == :groups ? "拼团" : "秒杀"
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
      @group.status = 1
      @group.sku_info = {t_spu_id: @sku.t_spu_id, title: @sku.title, t_category_id: @sku.t_spu.t_category_id}
      if @group.save
        flash[:success] = "创建拼团活动成功"
        redirect(url(:groups, :index))
      else
        raise "创建拼团活动失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'groups/new'
    end
  end

  # 拼团列表
  get :index do
    @groups = current_account.merchant.groups
    @groups = @groups.where("title like ?" ,"%#{params[:title]}%") if params[:title].present?
    @groups = @groups.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'groups/index'
  end

  # 修改状态
  get :change_status, :with => :id do
    begin
      @group = Group.find(params[:id])
      if @group.status == 1 # 发布中 可下架、未成团、成团
        if !(['0', '2', '3'].include? params[:status])
          raise "不可修改为未知的状态"
        end
      elsif @group.status == 0 # 下架的，可上架
        raise "下架中的团购 只能修改为发布" if params[:status] != '1'
      elsif ([2, 3].include? @group.status) # 成团或者未成团后，不可修改状态
        raise "该团已结束，不可再修改状态"
      end
      @group.update!(status: params[:status])
      flash[:notice] = "修改状态成功"
      redirect(url(:groups, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:groups, :index))
    end
  end

  # 编辑拼团
  get :edit, :with => :id do
    @group = Group.find(params[:id])
    render 'groups/edit'
  end

  # 修改拼团
  post :update, :with => :id do
    begin
      @group = Group.find(params[:id])
      raise "该团购不可修改" if @group.status != 1 # 上架的团购才可编辑
      raise "该团购已开始购买，不可修改价格" if @group.group_buyers.purchased.count > 0 && @group.group_price != BigDecimal.new(params[:group][:group_price])
      @group.update!(params[:group])
      flash[:notice] = "拼团信息修改成功"
      redirect(url(:groups, :index))
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      render 'groups/edit'
    end
  end

  # 团购展示
  get :show, :with => :id do
    @group = Group.find(params[:id])
    render 'groups/show'
  end

end
