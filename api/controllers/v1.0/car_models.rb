# encoding: utf-8
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0' do
  before do
    load_api_request_params
  end

  # 选择车品牌
  get :car_brands, :provides => [:json] do
    api_rescue do
      # authenticate_access_token

      @car_brands = CarBrand.order(:id => :asc)
      { status: 'succ', data: @car_brands.map(&:to_api)}.to_json
    end
  end

end
