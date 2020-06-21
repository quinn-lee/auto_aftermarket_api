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
        flash.now[:success] = "目录创建成功"
        redirect(url(:categories, :index))
      else
        raise "目录创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
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
        flash.now[:success] = "属性添加成功"
        redirect(url(:categories, :index))
      else
        raise "属性创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
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


end
