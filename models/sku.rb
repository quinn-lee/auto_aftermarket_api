require 'carrierwave/orm/activerecord'
class Sku < ActiveRecord::Base
  belongs_to :goods, :class_name => 'Goods'

  mount_uploaders :pics, FileUploader

  def to_api
    {
      id: id,
      goods: goods.to_api_simple,
      sku_name: sku_name,
      sku_code: sku_code,
      price: price,
      stock_quantity: stock_quantity,
      weight: weight,
      pics: ["images/260811002.jpg", "images/1336270541.jpg"],
      attributes: Attribute.where(id: SkuAttribute.where(sku_code: sku_code).map(&:attribute_id)).map(&:to_api)
    }
  end

  def to_api_simple
    {
      id: id,
      sku_name: sku_name,
      sku_code: sku_code,
      price: price,
      stock_quantity: stock_quantity,
      weight: weight,
      pics: [],
      attributes: Attribute.where(id: SkuAttribute.where(sku_code: sku_code).map(&:attribute_id)).map(&:to_api)
    }
  end
end
