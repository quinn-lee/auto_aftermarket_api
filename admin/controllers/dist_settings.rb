AutoAftermarketApi::Admin.controllers :dist_settings do
  before do
    set_dist_settings_title_and_local
  end

  get :new do
    @dist_setting = DistSetting.first || DistSetting.new(merchant_id: current_account.merchant.id)
    @dist_setting.save
    render 'dist_settings/new'
  end

  post :update, :with => :id do
    begin
      @dist_setting = DistSetting.find(params[:id])
      if @dist_setting.update(params[:dist_setting])
        flash[:success] = "分销设置成功"
        redirect(url(:dist_settings, :new))
      else
        @dist_setting = DistSetting.find(params[:id])
        raise "分销设置失败"
      end
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'dist_settings/new'
    end

  end

end
