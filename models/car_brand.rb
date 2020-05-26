class CarBrand < ActiveRecord::Base

  def to_api
    {
      brand: brand,
      abc: PinYin.sentence(brand[0..1])[0].upcase,
      image_url: image_url
    }
  end

end
