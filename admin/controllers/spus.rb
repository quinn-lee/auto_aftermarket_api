AutoAftermarketApi::Admin.controllers :spus do
  get :select_category do
    @title = "选择商品目录"
    @categories = TCategory.all
    render 'spus/select_category'
  end

  post :new do
    begin
      @title = "填写产品信息"
      raise "请选择商品目录" if params[:category_2].blank?
      @category = TCategory.find(params[:category_2])
      @brands = TBrand.where(id: TCategoryBrand.where(t_category_id: @category.id).map(&:t_brand_id))
      @spu = TSpu.new(t_category_id: @category.id, merchant_id: current_account.merchant.id)
      render 'spus/new'
    rescue => e
      flash.now[:error] = e.message
      @title = "选择商品目录"
      @categories = TCategory.all
      render 'spus/select_category'
    end
  end

  post :create do
    begin
      @spu = TSpu.new(params[:t_spu])
      if @spu.save
        flash.now[:success] = "产品创建成功，请继续为该产品添加SKU"
        redirect(url(:spus, :add_sku, :id => @spu.id))
      else
        raise "产品创建失败"
      end
    rescue => e
      flash.now[:error] = e.message
      @title = "填写产品信息"
      @category = TCategory.find(@spu.t_category_id)
      @brands = TBrand.where(id: TCategoryBrand.where(t_category_id: @category.id).map(&:t_brand_id))
      render 'spus/new'
    end
  end

  get :add_sku, :with => :id do
    @spu = TSpu.find(params[:id])
    @category = TCategory.find(@spu.t_category_id)
    @attrs = TAttribute.where(t_category_id: @spu.t_category_id)
    @sku = TSku.new(t_spu_id: @spu.id, merchant_id: current_account.merchant.id)

    render "spus/add_sku"
  end

  post :create_sku, :with => :id do
    begin
      logger.info params
      @spu = TSpu.find(params[:id])
      @category = TCategory.find(@spu.t_category_id)
      @attrs = TAttribute.where(t_category_id: @spu.t_category_id)
      @sku = TSku.new(params[:t_sku])
      sale_attrs = []
      attrs = []
      service_fee = []
      @attrs.each do |tattr|
        logger.info tattr.name
        logger.info params[:t_sku][tattr.name]
        if tattr.selling
          raise "销售属性必须填写" if params[:t_sku][tattr.name.to_sym].blank?
          sale_attrs << {"#{tattr.name}" => params[:t_sku][tattr.name.to_sym]}
        end
        attrs << {"#{tattr.name}" => params[:t_sku][tattr.name.to_sym]}
      end
      logger.info sale_attrs
      logger.info attrs
      @sku.save
      flash.now[:success] = "SKU添加成功"
      redirect(url(:spus, :add_sku, :id => @sku.t_spu_id))
    rescue=>e
      flash.now[:error] = e.message
      render "spus/add_sku"
    end
  end

end
