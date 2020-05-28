class Car < ActiveRecord::Base
  def to_api
    {
      id: id,
      car_model_id: car_model_id,
      car_model_name: car_model_name,
      mileage: mileage,
      license_date: license_date.try{|l| l.strftime("%F")},
      color: color, 
      is_current: is_current
    }
  end
end
