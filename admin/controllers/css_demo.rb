AutoAftermarketApi::Admin.controllers :css_demo do
  get :index do
    render :index
  end

  get :schedule do
    render :schedule
  end
end