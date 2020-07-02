AutoAftermarketApi::Admin.controllers :categories do
  before do
    set_categories_title_and_local
  end

  # 目录列表
  get :index do
    @categories = TCategory.all
    render "categories/index"
  end

  # 新增目录
  get :new do
    @category = TCategory.new(parent_id: params[:parent_id])
    render "categories/new"
  end

  # 新增目录提交
  post :create do
    begin
      @category = TCategory.new(params[:t_category])
      @category.if_parent = false
      if @category.save!
        TCategory.where(id: @category.parent_id).update_all(if_parent: true)
        flash[:success] = "目录创建成功"
        redirect(url(:categories, :index))
      else
        raise "目录创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'categories/new'
    end
  end

  # 新增属性
  get :new_attribute, :with => :id  do
    @attribute = TAttribute.new(t_category_id: params[:id])
    render "categories/new_attribute"
  end

  # 新增属性
  post :create_attribute do
    begin
      @attribute = TAttribute.new(params[:t_attribute])
      raise "属性名称重复" if TAttribute.where(t_category_id: @attribute.t_category_id, name: @attribute.name).count > 0
      if @attribute.save!
        flash[:success] = "属性添加成功"
        redirect(url(:categories, :index))
      else
        raise "属性创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'categories/new_attribute'
    end
  end

  # 新增属性
  post :create_attrvalues, :with => :attr_id  do
    begin
      @attribute = TAttribute.find(params[:attr_id])
      raise "属性值不可为空" if params[:attr_values].blank?
      attr_values = params[:attr_values].to_s.split("|||")
      raise "属性值不可重复" if @attribute.t_attrvalues.where(value: attr_values).count > 0
      attr_values.each{|value| TAttrvalue.create!(t_category_id: @attribute.t_category_id, t_attribute_id: @attribute.id, value: value)}
      flash[:notice] = "属性值创建成功"
      redirect(url(:categories, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:categories, :index))
    end
  end

  # 新增品牌
  get :new_brands, :with => :id  do
    @category = TCategory.find(params[:id])
    render "categories/new_brands"
  end

  # 新增品牌
  post :create_brands, :with => :id do
    begin
      @category = TCategory.find(params[:id])
      raise "品牌名称不可为空" if params[:brands].blank?
      brands = params[:brands].to_s.split("|||")
      brands.each do |brand_name|
        unless brand = TBrand.find_by(name: brand_name)
          brand = TBrand.create(name: brand_name)
        end
        unless tcb = TCategoryBrand.find_by(t_category_id: @category.id, t_brand_id: brand.id)
          TCategoryBrand.create(t_category_id: @category.id, t_brand_id: brand.id)
        end
      end
      flash[:notice] = "品牌添加成功"
      redirect(url(:categories, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render "categories/new_brands"
    end
  end


end
