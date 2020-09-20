AutoAftermarketApi::Admin.controllers :finance do

  # ===== 记账 Income/IncomeReal =====
  get :incomes do
    query = Income.where(merchant_id: current_account.merchant_id)
    query = query.where('due_date >= ?', params[:due_date_ge]) if params[:due_date_ge].present?
    query = query.where('due_date <= ?', params[:due_date_le]) if params[:due_date_le].present?
    %w[client_name subject].each do |field|
      query = query.where(field => params[field].strip) if params[field].present?
    end
    @incomes = query.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 30)
    render 'finance/incomes/index'
  end

  get :incomes_new, :map => 'finance/incomes/new' do
    @income = Income.new
    render 'finance/incomes/new'
  end

  post :incomes_create, :map => 'finance/incomes/create' do
    # permit_fields = %w[client_name client_phone contract_no contract_date subject contract_amount due_date remark]
    @income = Income.new(params[:income])
    @income.account_id = current_account.id
    @income.merchant_id = current_account.merchant_id
    if @income.save
      flash[:success] = '新增应收信息成功'
      redirect url(:finance, :incomes)
    else
      flash[:error] = '新增应收信息失败'
      redirect url(:finance, :incomes_new)
    end
  end

  get :incomes_edit, :map => 'finance/incomes/:id/edit' do
    @income = Income.find(params[:id])
    render 'finance/incomes/edit'
  end

  put :incomes_update, :map => 'finance/incomes/:id/update' do
    @income = Income.find(params[:id])
    if @income.update(params[:income])
      flash[:success] = '修改应收信息成功'
      redirect url(:finance, :incomes)
    else
      flash[:error] = '修改应收信息失败'
      redirect url(:finance, :incomes_edit, :id => @income.id)
    end
  end

  get :incomes_delete, :map => 'finance/incomes/:id/delete' do
    begin
      @income = Income.find(params[:id])
      if @income.can_delete?
        @income.destroy!
        flash[:success] = '删除应收信息成功'
        redirect url(:finance, :incomes)
      else
        raise '该条应收信息不能删除'
      end
    rescue Exception => e
      flash[:error] = e.message
      redirect url(:finance, :incomes)
    end
  end

  get :income_reals_new, :map => 'finance/incomes/:id/income_reals/new' do
    @income = Income.find(params[:id])
    @income_real = @income.income_reals.new
  end

  # 加载实收列表, 局部视图 remote (#incomeRealsModal .modal-body)
  get :load_income_reals, :map => 'finance/incomes/:id/load_income_reals' do
    begin
      @income = Income.find(params[:id])

      if params[:remote] == 'true'
        html_content = partial 'finance/incomes/income_reals', :locals => { :income => @income, :income_reals => @income.income_reals }
        { :status => 'succ', :html => html_content }.to_json
      else
        { :status => 'succ', :data => @income.income_reals.to_api }.to_json
      end
    rescue Exception => e
      { :status => 'fail', :reason => e.message }.to_json
    end
  end

  post :income_reals_create, :map => 'finance/incomes/:id/income_reals/create' do
    begin
      @income = Income.find(params[:id])
      @income_real = @income.income_reals.new(params[:income_real])
      @income_real.account_id = current_account.id
      @income_real.merchant_id = current_account.merchant_id
      @income_real.save!
      flash[:success] = '新增实收信息成功'
      redirect url(:finance, :incomes)
    rescue Exception => e
      flash[:error] = e.message
      redirect url(:finance, :incomes)
    end
  end

  get :income_reals_delete, :map => 'finance/income_reals/:id/delete' do
    begin
      @income_real = IncomeReal.find(params[:id])
      @income_real.destroy!
      flash[:success] = '删除实收信息成功'
      redirect url(:finance, :incomes)
    rescue Exception => e
      flash[:error] = e.message
      redirect url(:finance, :incomes)
    end
  end

  # ===== 结账 Outlay/OutlayReal =====
  get :outlays do
    query = Outlay.where(merchant_id: current_account.merchant_id)
    query = query.where('due_date >= ?', params[:due_date_ge]) if params[:due_date_ge].present?
    query = query.where('due_date <= ?', params[:due_date_le]) if params[:due_date_le].present?
    %w[client_name subject].each do |field|
      query = query.where(field => params[field].strip) if params[field].present?
    end
    @outlays = query.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 30)
    render 'finance/outlays/index'
  end

  get :outlays_new, :map => 'finance/outlays/new' do
    @outlay = Outlay.new
    render 'finance/outlays/new'
  end

  post :outlays_create, :map => 'finance/outlays/create' do
    # permit_fields = %w[client_name client_phone contract_no contract_date subject contract_amount due_date remark]
    @outlay = Outlay.new(params[:outlay])
    @outlay.account_id = current_account.id
    @outlay.merchant_id = current_account.merchant_id
    if @outlay.save
      flash[:success] = '新增应付信息成功'
      redirect url(:finance, :outlays)
    else
      flash[:error] = '新增应付信息失败'
      redirect url(:finance, :outlays_new)
    end
  end

  get :outlays_edit, :map => 'finance/outlays/:id/edit' do
    @outlay = Outlay.find(params[:id])
    render 'finance/outlays/edit'
  end

  put :outlays_update, :map => 'finance/outlays/:id/update' do
    @outlay = Outlay.find(params[:id])
    if @outlay.update(params[:outlay])
      flash[:success] = '修改应付信息成功'
      redirect url(:finance, :outlays)
    else
      flash[:error] = '修改应付信息失败'
      redirect url(:finance, :outlays_edit, :id => @outlay.id)
    end
  end

  get :outlays_delete, :map => 'finance/outlays/:id/delete' do
    begin
      @outlay = Outlay.find(params[:id])
      if @outlay.can_delete?
        @outlay.destroy!
        flash[:success] = '删除应付信息成功'
        redirect url(:finance, :outlays)
      else
        raise '该条应付信息不能删除'
      end
    rescue Exception => e
      flash[:error] = e.message
      redirect url(:finance, :outlays)
    end
  end

  get :outlay_reals_new, :map => 'finance/outlays/:id/outlay_reals/new' do
    @outlay = Outlay.find(params[:id])
    @outlay_real = @outlay.outlay_reals.new
  end

  # 加载实收列表, 局部视图 remote (#outlayRealsModal .modal-body)
  get :load_outlay_reals, :map => 'finance/outlays/:id/load_outlay_reals' do
    begin
      @outlay = Outlay.find(params[:id])

      if params[:remote] == 'true'
        html_content = partial 'finance/outlays/outlay_reals', :locals => { :outlay => @outlay, :outlay_reals => @outlay.outlay_reals }
        { :status => 'succ', :html => html_content }.to_json
      else
        { :status => 'succ', :data => @outlay.outlay_reals.to_api }.to_json
      end
    rescue Exception => e
      { :status => 'fail', :reason => e.message }.to_json
    end
  end

  post :outlay_reals_create, :map => 'finance/outlays/:id/outlay_reals/create' do
    begin
      @outlay = Outlay.find(params[:id])
      @outlay_real = @outlay.outlay_reals.new(params[:outlay_real])
      @outlay_real.account_id = current_account.id
      @outlay_real.merchant_id = current_account.merchant_id
      @outlay_real.save!
      flash[:success] = '新增实付信息成功'
      redirect url(:finance, :outlays)
    rescue Exception => e
      flash[:error] = e.message
      redirect url(:finance, :outlays)
    end
  end

  get :outlay_reals_delete, :map => 'finance/outlay_reals/:id/delete' do
    begin
      @outlay_real = OutlayReal.find(params[:id])
      @outlay_real.destroy!
      flash[:success] = '删除实付信息成功'
      redirect url(:finance, :outlays)
    rescue Exception => e
      flash[:error] = e.message
      redirect url(:finance, :outlays)
    end
  end

  # ===== 现金流量表 CashFlow =====
  get :cash_flows do
    @cash_flows = CashFlow.where(merchant_id: current_account.merchant_id)
    @transaction_date_gt = params[:transaction_date_gt]
    @transaction_date_lt = params[:transaction_date_lt]
    @cash_flows = @cash_flows.where('transaction_date >= ?', params[:transaction_date_gt]) if params[:transaction_date_gt].present?
    @cash_flows = @cash_flows.where('transaction_date <= ?', params[:transaction_date_lt]) if params[:transaction_date_lt].present?

    @cfs = @cash_flows.select("subject, sum(amount) as total_amount").group("subject")
    @order = @cfs.find_by(subject: "order")
    @refund = @cfs.find_by(subject: "refund")
    @income = @cfs.find_by(subject: "income")
    @outlay = @cfs.find_by(subject: "outlay")
    @commission = @cfs.find_by(subject: "commission")
    render 'finance/cash_flows/index'
  end

  get :cash_flow_details do
    @cash_flows = CashFlow.where(merchant_id: current_account.merchant_id)
    @cash_flows = @cash_flows.where('transaction_date >= ?', params[:transaction_date_gt]) if params[:transaction_date_gt].present?
    @cash_flows = @cash_flows.where('transaction_date <= ?', params[:transaction_date_lt]) if params[:transaction_date_lt].present?
    @cash_flows = @cash_flows.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 30)
    render 'finance/cash_flows/cash_flow_details'
  end

  # ===== 财务对账 ReconciliationDetail =====
  get :reconciliation_details do
    @reconciliation_details = ReconciliationDetail.where(merchant_id: current_account.merchant_id)
    @reconciliation_details = @reconciliation_details.order(:created_at => :desc).paginate(:page => params[:page], :per_page => 30)
    render 'finance/reconciliation_details/index'
  end

end
