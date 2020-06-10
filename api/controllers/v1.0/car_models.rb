# encoding: utf-8

#汽车车型选择相关接口
AutoAftermarketApi::Api.controllers :'v1.0', :map => 'v1.0' do
  before do
    load_api_request_params
  end

  # 选择车品牌
  # params 空
  # data [{"brand":"奥迪","abc":"A","image_url":"http://image.bitautoimg.com/bt/car/default/images/logo/masterbrand/png/100/m_9_100.png"}...]
  post :car_brands, :provides => [:json] do
    api_rescue do
      authenticate

      @car_brands = CarBrand.order(:id => :asc)
      { status: 'succ', data: @car_brands.map(&:to_api)}.to_json
    end
  end

  # 选择车型
  # params {"brand": "奥迪", "car_model": "A4L"}
  # data [{"brand": "奥迪", "car_model": "奥迪A4L", "manufacturer": "一汽-大众奥迪>>"}...]
  post :car_models, :provides => [:json] do
    api_rescue do
      authenticate
      @car_years = CarYear.all
      @car_years = @car_years.where(brand: @request_params["brand"]) if @request_params["brand"].present?
      @car_years = @car_years.where("car_model like '%#{@request_params["car_model"]}%'") if @request_params["car_model"].present?
      @car_years = @car_years.order(:id => :asc)
      { status: 'succ', data: @car_years.map(&:to_api).uniq}.to_json
    end
  end

  # 选择车型年份
  # params {"brand": "奥迪", "model": "奥迪A4L"}
  # data [{"year_id": 1,"year": "2020款"}...]
  post :car_model_years, :provides => [:json] do
    api_rescue do
      authenticate

      @car_years = CarYear.where(brand: @request_params["brand"], car_model: @request_params["model"]).order(:id => :asc)
      { status: 'succ', data: @car_years.map(&:to_api_year).uniq}.to_json
    end
  end

  # 选择车款
  # params {"year_id": 1}
  # data [{"model_id": 1, "model_version": "35 TFSI 时尚动感型"}...]
  post :car_model_versions, :provides => [:json] do
    api_rescue do
      authenticate

      @car_models = CarModel.where(car_year_id: @request_params["year_id"]).order(:id => :asc)
      { status: 'succ', data: @car_models.map(&:to_api).uniq}.to_json
    end
  end

end
