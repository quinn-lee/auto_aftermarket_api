AutoAftermarketApi::Admin.controllers :accounts do

  get :index do
    @title = "员工"
    @accounts = Account.where("role_id > 3")
    @accounts = @accounts.where(role_id: params[:role_id]) if params[:role_id].present?
    @accounts = @accounts.where("name like '%#{params[:name]}%'") if params[:name].present?
    @accounts = @accounts.where("email like '%#{params[:email]}%'") if params[:email].present?
    @accounts = @accounts.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'accounts/index'
  end

  get :dists do
    @title = "分销"
    @accounts = Account.where.not(role_id: [3, 4])
    @accounts = @accounts.where(role_id: params[:role_id]) if params[:role_id].present?
    @accounts = @accounts.where("name like '%#{params[:name]}%'") if params[:name].present?
    @accounts = @accounts.where("email like '%#{params[:email]}%'") if params[:email].present?
    @accounts = @accounts.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'accounts/dists'
  end

  get :dist_orders, :with => :account_id do
    @title = "分销"
    @dist_orders = DistOrder.where(merchant_id: current_account.merchant.id).where(dist_agent_id: params[:account_id])
    @dist_orders = @dist_orders.order("created_at desc").paginate(page: params[:page], per_page: 30)
    render 'accounts/dist_orders'
  end

  get :new do
    @title = pat(:new_title, :model => 'account')
    @from = 'new'
    @account = Account.new
    render 'accounts/new'
  end

  post :create do
    @account = Account.new(params[:account])
    @account.merchant_id = current_account.merchant_id
    @account.shop_id = current_account.shop_id
    @from = params[:from]
    if @account.save
      @title = '创建用户'
      flash[:success] = "用户创建成功"
      redirect(url(:accounts, :index))
    else
      @title = '创建用户'
      flash[:error] = "用户创建失败"
      render 'accounts/new'
    end
  end

  get :edit, :with => :id do
    @title = '编辑用户'
    @from = 'edit'
    @account = Account.find(params[:id])
    if @account
      render 'accounts/edit'
    else
      flash[:warning] = '用户未找到'
      halt 404
    end
  end

  get :edit_password, :with => :id do
    @title = '修改密码'
    @from = 'edit_password'
    @account = Account.find(params[:id])
    if @account
      render 'accounts/edit_password'
    else
      flash[:warning] = '用户未找到'
      halt 404
    end
  end

  put :update, :with => :id do
    @title = '修改用户'
    @from = params[:from]
    @account = Account.find(params[:id])
    if @account
      if @account.update_attributes(params[:account])
        flash[:success] = '用户修改成功'
        redirect(url(:accounts, :index))
      else
        flash[:error] = '用户修改失败'
        render "accounts/#{params[:from]}"
      end
    else
      flash[:warning] = '用户未找到'
      halt 404
    end
  end

  get :destroy, :with => :id do
    @title = "Accounts"
    account = Account.find(params[:id])
    if account
      if account != current_account && account.destroy
        flash[:success] = '用户删除成功'
      else
        flash[:error] = '用户删除失败'
      end
      redirect url(:accounts, :index)
    else
      flash[:warning] = '用户未找到'
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Accounts"
    unless params[:account_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'account')
      redirect(url(:accounts, :index))
    end
    ids = params[:account_ids].split(',').map(&:strip)
    accounts = Account.find(ids)

    if accounts.include? current_account
      flash[:error] = pat(:delete_error, :model => 'account')
    elsif Account.destroy accounts

      flash[:success] = pat(:destroy_many_success, :model => 'Accounts', :ids => "#{ids.join(', ')}")
    end
    redirect url(:accounts, :index)
  end
end
