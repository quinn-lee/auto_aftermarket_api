class Car < ActiveRecord::Base
  def to_api
    {
      id: id,
      car_model_id: car_model_id,
      car_model_name: car_model_name,
      is_current: is_current
    }
  end
end
