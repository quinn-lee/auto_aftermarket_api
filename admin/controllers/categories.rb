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


end
