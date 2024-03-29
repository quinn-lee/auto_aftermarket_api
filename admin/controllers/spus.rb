AutoAftermarketApi::Admin.controllers :spus do
  before do
    set_spus_title_and_local
  end

  # 产品列表
  get :index do
    @spus = current_account.merchant.t_spus
    @categories = TCategory.all
    @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
    @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
    @spus = @spus.where("title like '%#{params[:title]}%'") if params[:title].present?
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
      flash[:error] = e.message
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
        flash[:success] = "产品创建成功，请继续为该产品添加SKU"
        redirect(url(:spus, :add_sku, :id => @spu.id))
      else
        raise "产品创建失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
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
      @sku.save!
      flash[:success] = "SKU添加成功，您可以继续为该SPU添加SKU"
      redirect(url(:spus, :add_sku, :id => @sku.t_spu_id))
    rescue=>e
      logger.info e.backtrace
      flash[:error] = e.message
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
          flash[:success] = "产品修改成功"
          redirect(url(:spus, :index))
        else
          raise "产品修改失败"
        end
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
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
          flash[:success] = "商品修改成功"
          redirect(url(:spus, :show, :id => @sku.t_spu.id))
        else
          raise "商品品修改失败"
        end
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'spus/edit_sku'
    end
  end

  # 商品展示
  get :show_sku, :with => :sku_id do
    @sku = TSku.find(params[:sku_id])
    render "spus/show_sku"
  end

  # 调整图片顺序
  get :ordering_imgs, :with => :id do
    @spu = TSpu.find(params[:id])
    render "spus/ordering_imgs"
  end

  # 调整图片顺序
  # post :ordered_imgs, :with => :id do
  #   begin
  #     logger.info params
  #     @spu = TSpu.find(params[:id])
  #     arr_h = {}
  #     params.each do |k,v|
  #       arr_h[k.to_s.delete("order_")]=v if k.to_s.include?"order_"
  #     end
  #     details = []
  #     (arr_h.sort_by {|k,v| v}).each{|item| details << @spu.details[item[0].to_i-1]}
  #     @spu.update!(details: details)
  #     flash[:success] = "图片顺序修改成功"
  #     redirect(url(:spus, :edit, :id => @spu.id))
  #
  #   rescue => e
  #     logger.info e.backtrace
  #     flash[:error] = e.message
  #     render 'spus/ordering_imgs'
  #   end
  # end

  # 调整产品详情图片顺序
  post :reorder_details, :with => :id do
    begin
      seq = params[:_seq_].split(',').map(&:to_i)
      @spu = TSpu.find(params[:id])
      details = []
      seq.each{ |i| details << @spu.details[i] }
      @spu.update!(details: details)
      flash[:success] = '图片顺序修改成功'
      redirect(url(:spus, :edit, :id => @spu.id))
    rescue => e
      flash[:error] = e.message
      render 'spus/ordering_imgs'
    end
  end

  # 商品匹配车型
  get :select_car_model, :with => :sku_id do
    @sku = TSku.find(params[:sku_id])
    @car_brands = CarBrand.order(:id => :asc)
    if params[:brand].present?
      @brand = CarBrand.find(params[:brand])
      @car_models = CarYear.where(brand: @brand.brand).map(&:car_model).uniq
    end
    if params[:car_model].present?
      @car_model = params[:car_model]
      @car_years = CarYear.where(brand: @brand.brand, car_model: @car_model)
    end
    if params[:year_id].present?
      @car_year = CarYear.find(params[:year_id])
      @model_versions = CarModel.where(car_year_id: @car_year.id)
    end
    render "spus/select_car_model"
  end

  post :selected_car_model, :with => :sku_id do
    begin
      @sku = TSku.find(params[:sku_id])
      @car_brands = CarBrand.order(:id => :asc)
      if params[:brand].present?
        @brand = CarBrand.find(params[:brand])
        @car_models = CarYear.where(brand: @brand.brand).map(&:car_model).uniq
      end
      if params[:car_model].present?
        @car_model = params[:car_model]
        @car_years = CarYear.where(brand: @brand.brand, car_model: @car_model)
      end
      if params[:year_id].present?
        @car_year = CarYear.find(params[:year_id])
        @model_versions = CarModel.where(car_year_id: @car_year.id)
      end
      raise "请勾选年份或车型" if params[:model_ids].blank? && params[:year_ids].blank?
      ActiveRecord::Base.transaction do
        if params[:model_ids].present?
          CarModel.where(id: params[:model_ids]).each do |car_model|
            unless cms = CarModelSku.find_by(car_model_id: car_model.id, t_sku_id: @sku.id, merchant_id: current_account.merchant.id)
              CarModelSku.create!(car_model_id: car_model.id, t_sku_id: @sku.id, merchant_id: current_account.merchant.id, t_category_id: @sku.t_spu.t_category_id)
            end
          end
        end
        if params[:year_ids].present?
          CarYear.where(id: params[:year_ids]).each do |car_year|
            car_year.car_models.each do |car_model|
              unless cms = CarModelSku.find_by(car_model_id: car_model.id, t_sku_id: @sku.id, merchant_id: current_account.merchant.id)
                CarModelSku.create!(car_model_id: car_model.id, t_sku_id: @sku.id, merchant_id: current_account.merchant.id, t_category_id: @sku.t_spu.t_category_id)
              end
            end
          end
        end
      end
      flash[:success] = "车型匹配成功"
      redirect(url(:spus, :select_car_model, :sku_id => @sku.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'spus/select_car_model'
    end
  end

  get :unselected_car_model, :with => :sku_id do
    begin
      @sku = TSku.find(params[:sku_id])
      cmss = CarModelSku.where(car_model_id: params[:car_model_id], t_sku_id: @sku.id, merchant_id: current_account.merchant.id)
      ActiveRecord::Base.transaction do
        cmss.delete_all
      end
      flash[:success] = "车型匹配删除成功"
      redirect(url(:spus, :select_car_model, :sku_id => @sku.id))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'spus/select_car_model'
    end
  end

end
