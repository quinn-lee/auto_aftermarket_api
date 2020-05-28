require 'carrierwave/orm/activerecord'
class Goods < ActiveRecord::Base
  has_many :skus, :class_name => 'Sku'
  belongs_to :category, :class_name => "Category"
  mount_uploaders :pics, FileUploader


  def to_api
    {
      id: id,
      description: description,
      category: category.to_api,
      pics: ["images/260811002.jpg", "images/1336270541.jpg"],
      desc_pics: [],
      attributes: Attribute.where(id: GoodsAttribute.where(goods_id: id).map(&:attribute_id)).map(&:to_api),
      skus: skus.map(&:to_api_simple)
    }
  end

  def to_api_simple
    {
      id: id,
      description: description,
      category: category.to_api,
      pics: ["images/260811002.jpg", "images/1336270541.jpg"],
      desc_pics: [],
      attributes: Attribute.where(id: GoodsAttribute.where(goods_id: id).map(&:attribute_id)).map(&:to_api),
    }
  end
end
