# encoding: utf-8
# 客户所选汽车
class Car < ActiveRecord::Base
  def to_api
    begin
      brand = CarBrand.find_by(brand: CarYear.find(CarModel.find(car_model_id).car_year_id).brand)
    rescue
      brand = nil
    end
    {
      id: id,
      car_model_id: car_model_id,
      car_model_name: car_model_name,
      mileage: mileage,
      license_date: license_date.try{|l| l.strftime("%F")},
      color: color,
      is_current: is_current,
      brand: brand.present? ? brand.brand : "",
      brand_image_url: brand.present? ? brand.image_url : ""
    }
  end
end
