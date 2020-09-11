AutoAftermarketApi::Admin.controllers :dist_settings do
  before do
    set_dist_settings_title_and_local
  end

  get :new do
    @dist_setting = DistSetting.find_by(merchant_id: current_account.merchant.id) || DistSetting.new(merchant_id: current_account.merchant.id)
    @dist_setting.save
    render 'dist_settings/new'
  end

  post :update, :with => :id do
    begin
      @dist_setting = DistSetting.find(params[:id])
      if @dist_setting.update(params[:dist_setting])
        if params[:from] == 'dist_roles'
          flash[:success] = "分销比例设置成功"
          redirect(url(:dist_settings, :dist_roles))
        else
          flash[:success] = "分销设置成功"
          redirect(url(:dist_settings, :new))
        end
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

  get :dist_roles do
    @dist_roles = DistRole.all
    @dist_setting = DistSetting.find_by(merchant_id: current_account.merchant.id) || DistSetting.new(merchant_id: current_account.merchant.id)
    render 'dist_settings/dist_roles'
  end

  get :new_dist_role do
    @dist_role = DistRole.new(merchant_id: current_account.merchant.id)
    render 'dist_settings/new_dist_role'
  end

  post :create_dist_role do
    begin
      @dist_role = DistRole.new(params[:dist_role])
      @dist_role.save!
      flash[:notice] = "新增分销角色成功"
      redirect(url(:dist_settings, :dist_roles))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'dist_settings/new_dist_role'
    end
  end

  get :edit_dist_role, :with => :id do
    @dist_role = DistRole.find(params[:id])
    render 'dist_settings/edit_dist_role'
  end

  post :update_dist_role, :with => :id do
    begin
      @dist_role = DistRole.find(params[:id])
      @dist_role.update!(params[:dist_role])
      flash[:notice] = "修改分销角色成功"
      redirect(url(:dist_settings, :dist_roles))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      render 'dist_settings/edit_dist_role'
    end
  end

  get :destroy_dist_role, :with => :id do
    @dist_role = DistRole.find(params[:id])
    @dist_role.destroy
    flash[:notice] = "删除分销角色成功"
    redirect(url(:dist_settings, :dist_roles))
  end

end
