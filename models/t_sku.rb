require 'carrierwave/orm/activerecord'
class TSku < ActiveRecord::Base
  mount_uploaders :images, FileUploader
  mount_uploaders :detail, FileUploader

  validates :t_spu_id, :merchant_id, :title, :images, :price, :stock_num, :available_num, presence: true

  belongs_to :t_spu,   :class_name => 'TSpu'
  belongs_to :merchant,   :class_name => 'Merchant'

  PREFERRED = {
    1 => '优选',
    0 => '普通'
  }.stringify_keys

  def to_api
    {
      id: id,
      spu: t_spu.to_api_simple,
      title: title,
      sku_code: sku_code,
      price: price,
      service_fee: service_fee,
      stock_num: stock_num,
      available_num: available_num,
      preferred: PREFERRED[preferred.to_s],
      images: images.try{|i| i.map(&:url)},
      sale_attrs: sale_attrs,
      attrs: attrs,
      detail: detail.try{|i| i.map(&:url)}
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
      available_num: available_num,
      preferred: PREFERRED[preferred],
      images: images.try{|i| i.map(&:url)},
      sale_attrs: sale_attrs,
      attrs: attrs,
      detail: detail.try{|i| i.map(&:url)}
    }
  end

  def to_api_order
    {
      id: id,
      title: title,
      sku_code: sku_code,
      images: images.try{|i| i.map(&:url)},
    }
  end

  def saleable_class
    saleable ? "pd-setting" : "ds-setting"
  end
  def saleable_desc
    saleable ? "正常" : "已下架"
  end

  def sale_attrs_desc
    sale_attrs.to_a.map{|sa| sa.join(':')}.join('，')
  end
end
