AutoAftermarketApi::Admin.controllers :categories do
  before do
    set_categories_title_and_local
  end

  # 目录列表
  get :index do
    @categories = TCategory.all
    @first_category = @categories.where(parent_id: nil).order("id asc").first
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

  # 隐藏/展示
  get :hidden, with: :id do
    begin
      @category = TCategory.find(params[:id])
      @category.update!(is_hidden: params[:is_hidden])
      flash[:notice] = "目录修改成功"
      redirect(url(:categories, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:categories, :index))
    end
  end

  # 删除
  get :delete, with: :id do
    begin
      @category = TCategory.find(params[:id])
      raise "该目录无法删除" unless @category.can_delete?
      @category.do_delete!
      flash[:notice] = "目录删除成功"
      redirect(url(:categories, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:categories, :index))
    end
  end

  get :load_second_cell do
    category = TCategory.find(params[:id])
    sub_categories = TCategory.all.where(parent_id: params[:id]).order("id asc").map{|sub_category|{:id=>sub_category.id , :name=>sub_category.name} }
    {:sub_categories => sub_categories , :is_hidden=>category.is_hidden , :can_delete=>category.can_delete?}.to_json
  end

  get :load_third_cell do
    t_category = TCategory.find(params[:id])
    brands = t_category.brands.map{|brand|{:name=>brand.name}}
    attrs = t_category.t_attributes.map{|t_attribute|{:name=>t_attribute.name, :id=> t_attribute.id}}
    {:brands => brands,:attrs => attrs, :is_hidden=>t_category.is_hidden, :can_delete=>t_category.can_delete?}.to_json
  end

  get :load_attr do
    t_attr = TAttribute.find(params[:id])
    {:name=>t_attr.name,:selling_desc=>t_attr.selling_desc,:searching_desc=>t_attr.searching_desc,:unit=>t_attr.unit,:t_attrvalues=>t_attr.t_attrvalues.map(&:value).join(",")}.to_json
  end

end
