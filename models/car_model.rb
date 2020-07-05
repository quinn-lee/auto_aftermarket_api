# encoding: utf-8
# 汽车车型
class CarModel < ActiveRecord::Base
  def to_api
    {
      model_id: id,
      model_version: car_model_version
    }
  end
end
