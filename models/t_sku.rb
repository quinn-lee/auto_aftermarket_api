require 'carrierwave/orm/activerecord'
class TSku < ActiveRecord::Base
  mount_uploaders :images, FileUploader
  mount_uploaders :detail, FileUploader

  validates :t_spu_id, :merchant_id, :title, :images, :price, :stock_num, presence: true

  belongs_to :t_spu,   :class_name => 'TSpu'
  belongs_to :merchant,   :class_name => 'Merchant'

  def to_api
    {
      id: id,
      spu: t_spu.to_api_simple,
      title: title,
      sku_code: sku_code,
      price: price,
      service_fee: service_fee,
      stock_num: stock_num,
      images: images.map(&:url),
      sale_attrs: sale_attrs,
      attrs: attrs
    }
  end

  def to_api_simple
    {
      id: id,
      title: title,
      sku_code: sku_code,
      price: price,
      service_fee: service_fee,
      stock_num: stock_num,
      images: images.map(&:url),
      sale_attrs: sale_attrs,
      attrs: attrs
    }
  end

  def to_api_order
    {
      id: id,
      title: title,
      sku_code: sku_code,
      images: images.map(&:url)
    }
  end
end
