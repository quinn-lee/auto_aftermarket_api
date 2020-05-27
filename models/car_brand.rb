class CarBrand < ActiveRecord::Base

  def to_api
    {
      brand: brand,
      abc: abc,
      image_url: image_url
    }
  end

end
