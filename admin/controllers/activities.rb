AutoAftermarketApi::Admin.controllers :activities do
  before do
    set_activities_title_and_local
  end

  get :index do
    @activities = Activity.where(merchant_id: current_account.merchant.id)
    @activities = @activities.order("created_at asc").paginate(page: params[:page], per_page: 30)
    render 'activities/index'
  end

  get :new do
    @activity = Activity.new(merchant_id: current_account.merchant.id)
    render 'activities/new'
  end

  post :create do
    begin
      @activity = Activity.new(params[:activity])
      if @activity.save
        flash[:success] = "创建营销活动成功"
        redirect(url(:activities, :index))
      else
        raise "创建营销活动失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'activities/new'
    end

  end

  get :destroy, :with => :id do
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:success] = "营销活动删除成功"
    redirect(url(:activities, :index))
  end

end
