AutoAftermarketApi::Admin.controllers :agent_changes do
  before do
    set_agent_changes_title_and_local
  end

  # 更换分销员申请列表
  get :index do
    @agent_changes = AgentChange.where(merchant_id: current_account.merchant_id, status: 0)
    @agent_changes = @agent_changes.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'agent_changes/index'
  end

  post :change do
    begin
      @agent_change = AgentChange.find(params[:id])
      raise "分销员不能为空" if params[:new_agent_id].blank?
      @agent_change.update!(old_agent_id: @agent_change.account.dist_agent_id, staff_id: current_account.id, status: 1)
      @agent_change.account.update!(dist_agent_id: params[:new_agent_id])
      @agent_change.change_subscribe #订阅消息
      flash[:success] = "操作成功"
      redirect(url(:agent_changes, :index))
    rescue => e
      logger.info e.backtrace
      flash[:error] = e.message
      redirect(url(:agent_changes, :index))
    end
  end

end
