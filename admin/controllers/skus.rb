AutoAftermarketApi::Admin.controllers :skus do
  before do
    set_skus_title_and_local
  end

  # 优选sku列表
  get :preferred do
    @spus = current_account.merchant.t_spus
    @categories = TCategory.all
    @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
    @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?

    @skus = TSku.where(preferred: 1, t_spu_id: @spus.map(&:id))
    @skus = @skus.where("title like '%#{params[:title]}%'") if params[:title].present?
    @skus = @skus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'skus/preferred'
  end

  get :select_sku do
    @spus = current_account.merchant.t_spus
    @categories = TCategory.all
    @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
    @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
    @spus = @spus.where("title like '%#{params[:title]}%'") if params[:title].present?
    @spus = @spus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'skus/select_sku'
  end

  get :change_preferred, :with => :sku_id do
    begin
      @sku = TSku.find(params[:sku_id])
      @sku.update!(preferred: params[:option])
      if params[:option] == '0'
        flash[:notice] = "已从优选商品中删除"
        redirect(url(:skus, :preferred))
      else
        flash[:notice] = "添加为优选商品成功，您可以继续添加"
        redirect(url(:skus, :select_sku))
      end
    rescue => e
      logger.info e.backtrace
      flash.now[:error] = e.message
      redirect(url(:skus, :preferred))
    end
  end

end
