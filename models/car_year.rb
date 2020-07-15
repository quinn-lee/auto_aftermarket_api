# encoding: utf-8
# 汽车年款
class CarYear < ActiveRecord::Base
  has_many :car_models, :class_name => 'CarModel', :dependent => :destroy
  def to_api
    {
      brand: brand,
      car_model: car_model,
      manufacturer: manufacturer
    }
  end

  def to_api_year
    {
      year_id: id,
      year: year
    }
  end
end
