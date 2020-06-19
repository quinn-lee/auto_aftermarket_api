AutoAftermarketApi::Admin.controllers :categories do
  before do
    set_categories_title_and_local
  end

  get :index do
    @categories = TCategory.all
    render "categories/index"
  end

end
