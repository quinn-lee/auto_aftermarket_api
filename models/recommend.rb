class Recommend < ActiveRecord::Base

  def to_api
    {
      name: name,
      rtype: rtype,
      quantity: quantity,
      sku: Sku.find(sku_id).to_api
    }
  end
end
