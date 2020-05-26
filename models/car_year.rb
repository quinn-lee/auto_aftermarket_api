class CarYear < ActiveRecord::Base

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
