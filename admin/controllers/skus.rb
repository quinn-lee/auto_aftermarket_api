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

    @skus = TSku.where(t_spu_id: @spus.map(&:id)).where.not(preferred: 0)
    @skus = @skus.where("title like '%#{params[:title]}%'") if params[:title].present?
    @skus = @skus.order("preferred desc").order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'skus/preferred'
  end

  # 选择优选商品页面
  get :select_spu do
    @spus = current_account.merchant.t_spus
    @categories = TCategory.all
    @spus = @spus.where(t_category_id: TCategory.where(parent_id: params[:category_1]).map(&:id)) if params[:category_1].present?
    @spus = @spus.where(t_category_id: params[:category_2]) if params[:category_2].present?
    @spus = @spus.where(t_brand_id: params[:brand_id]) if params[:brand_id].present?
    @spus = @spus.where("title like '%#{params[:title]}%'") if params[:title].present?
    @spus = @spus.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'skus/select_spu'
  end

   get :select_sku do
    @spu = TSpu.find(params[:spu_id])
    @skus = @spu.t_skus
    render 'skus/select_sku'
  end

  # 修改 优选商品
  get :change_preferred, :with => :sku_id do
    begin
      @sku = TSku.find(params[:sku_id])
      raise "优先级必须选择" unless params[:option].present?
      if params[:option] != "0" # 添加为优选时，广告语必须输入且不能超过12个字
        raise "广告语必须输入" if params[:preferred_slogan].blank?
        raise "广告语不能超过12个字" if params[:preferred_slogan].to_s.length > 12
      end
      if params[:option] == '0' # 从优选商品中删除
        @sku.update!(preferred: params[:option], preferred_slogan: nil)
      else
        @sku.update!(preferred: params[:option], preferred_slogan: params[:preferred_slogan], label_id: params[:label_id])
      end
      if params[:option] == '0'
        flash[:notice] = "已从优选商品中删除"
        redirect(url(:skus, :preferred))
      else
        if params[:from] == "modify" # 修改广告语
          flash[:notice] = "广告语修改成功"
          redirect(url(:skus, :preferred))
        else
          flash[:notice] = "添加为优选商品成功，您可以继续添加"
          redirect(url(:skus, :select_spu))
        end
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      if params[:option] == '0'
        redirect(url(:skus, :preferred))
      else
        if params[:from] == "modify" # 修改广告语
          redirect(url(:skus, :preferred))
        else
          redirect(url(:skus, :select_spu))
        end
      end
    end
  end

end
