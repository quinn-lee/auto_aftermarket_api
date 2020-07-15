# encoding: utf-8
# 汽车车型
class CarModel < ActiveRecord::Base
  belongs_to :car_year,   :class_name => 'CarYear'
  def to_api
    {
      model_id: id,
      model_version: car_model_version
    }
  end
end
