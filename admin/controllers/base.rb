AutoAftermarketApi::Admin.controllers :base do
  get :index, :map => "/" do
    redirect(url(:spus, :index))
  end
end
