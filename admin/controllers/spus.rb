AutoAftermarketApi::Admin.controllers :spus do
  before do
    set_spus_title_and_local
  end

  # 产品列表
  get :index do
    @spus = current_account.merchant.t_spus
    @spus = @spus.where(t_category_id: params[:category_id]) if params[:category_id].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
    @spus = @spus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'spus/index'
  end

  # 新增产品 选择目录
  get :select_category do
    @categories = TCategory.all
    render 'spus/select_category'
  end

  # 新增产品
  post :new do
    begin
      raise "请选择商品目录" if params[:category_2].blank?
      @category = TCategory.find(params[:category_2])
      raise "该商品目录未创建任何属性值，请先到目录列表为该目录创建属性" unless @category.t_attributes.present?
      @brands = TBrand.where(id: TCategoryBrand.where(t_category_id: @category.id).map(&:t_brand_id))
      @spu = TSpu.new(t_category_id: @category.id, merchant_id: current_account.merchant.id)
      render 'spus/new'
    rescue => e
      flash.now[:error] = e.message
      @categories = TCategory.all
      render 'spus/select_category'
    end
  end

  # 新增产品 提交
  post :create do
    begin
      @spu = TSpu.new(params[:t_spu])
      @spu.saleable = true
      @spu.is_valid = true
      if @spu.save
        flash.now[:success] = "产品创建成功，请继续为该产品添加SKU"
        redirect(url(:spus, :add_sku, :id => @spu.id))
      else
        raise "产品创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      @category = TCategory.find(@spu.t_category_id)
      @brands = TBrand.where(id: TCategoryBrand.where(t_category_id: @category.id).map(&:t_brand_id))
      render 'spus/new'
    end
  end

  # 添加SKU
  get :add_sku, :with => :id do
    @spu = TSpu.find(params[:id])
    @category = TCategory.find(@spu.t_category_id)
    @attrs = TAttribute.where(t_category_id: @spu.t_category_id)
    @sku = TSku.new(t_spu_id: @spu.id, merchant_id: current_account.merchant.id)

    render "spus/add_sku"
  end

  # 添加SKU 提交
  post :create_sku, :with => :id do
    begin
      logger.info params
      @spu = TSpu.find(params[:id])
      @category = TCategory.find(@spu.t_category_id)
      @attrs = TAttribute.where(t_category_id: @spu.t_category_id)
      @sku = TSku.new(params[:t_sku])
      sale_attrs = {}
      attrs = {}
      service_fee = {}
      @attrs.each do |tattr|
        if tattr.selling
          raise "销售属性必须填写" if params[tattr.name.to_sym].blank?
          sale_attrs[tattr.name] = params[tattr.name.to_sym]
        end
        attrs[tattr.name] = params[tattr.name.to_sym]
      end
      if params[:service].present?
        params[:service].each do |s|
          raise "服务费用必须填写" if params[s.to_sym].blank?
          service_fee[s] = params[s.to_sym]
        end

      end
      @sku.sale_attrs = sale_attrs
      @sku.attrs = attrs
      @sku.service_fee = service_fee
      @sku.saleable = true
      @sku.is_valid = true
      @sku.save
      flash[:success] = "SKU添加成功，您可以继续为该SPU添加SKU"
      redirect(url(:spus, :add_sku, :id => @sku.t_spu_id))
    rescue=>e
      logger.info e.backtrace
      flash.now[:error] = e.message
      render "spus/add_sku"
    end
  end

  # 产品编辑
  get :edit, :with => :id do
    @spu = TSpu.find(params[:id])
    @brands = TBrand.where(id: TCategoryBrand.where(t_category_id: @spu.t_category.id).map(&:t_brand_id))
    render "spus/edit"
  end

  # 产品编辑 提交
  post :update, :with => :id do
    begin
      if @spu = TSpu.find(params[:id])
        if @spu.update!(params[:t_spu])
          flash.now[:success] = "产品修改成功"
          redirect(url(:spus, :index))
        else
          raise "产品修改失败"
        end
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      @brands = TBrand.where(id: TCategoryBrand.where(t_category_id: @spu.t_category.id).map(&:t_brand_id))
      render 'spus/edit'
    end
  end

  # 产品上下架
  get :change_sale, :with => :id do
    begin
      @spu = TSpu.find(params[:id])
      saleable = params[:action] == "onsale" ? true : false
      @spu.update!(saleable: saleable)
      @spu.t_skus.update_all(saleable: saleable)
      flash[:success] = "产品(SPU)#{params[:action] == "onsale" ? '上架' : '下架'}成功"
      redirect(url(:spus, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:spus, :index))
    end
  end

  # SPU详情
  get :show, :with => :id do
    begin
      @spu = TSpu.find(params[:id])
      render "spus/show"
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render "spus/show"
    end
  end

  # 产品上下架
  get :change_sku_sale, :with => :sku_id do
    begin
      @sku = TSku.find(params[:sku_id])
      saleable = params[:action] == "onsale" ? true : false
      @sku.update!(saleable: saleable)
      flash[:success] = "商品(SKU)#{params[:action] == "onsale" ? '上架' : '下架'}成功"
      redirect(url(:spus, :show, :id => @sku.t_spu.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:spus, :show, :id => @sku.t_spu.id))
    end
  end

  # 商品编辑
  get :edit_sku, :with => :sku_id do
    @sku = TSku.find(params[:sku_id])
    render "spus/edit_sku"
  end

  # 商品编辑 提交
  post :update_sku, :with => :sku_id do
    begin
      if @sku = TSku.find(params[:sku_id])
        @sku.images = params[:images] if params[:images].present?
        @sku.detail = params[:detail] if params[:detail].present?
        if @sku.update!(params[:t_sku])
          flash.now[:success] = "商品修改成功"
          redirect(url(:spus, :show, :id => @sku.t_spu.id))
        else
          raise "商品品修改失败"
        end
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      render 'spus/edit_sku'
    end
  end

  # 商品展示
  get :show_sku, :with => :sku_id do
    @sku = TSku.find(params[:sku_id])
    render "spus/show_sku"
  end

end
