class TSku < ActiveRecord::Base
  belongs_to :t_spu,   :class_name => 'TSpu'
  belongs_to :merchant,   :class_name => 'Merchant'

  def to_api
    {
      id: id,
      spu: t_spu.to_api_simple,
      title: title,
      sku_code: sku_code,
      price: price,
      stock_num: stock_num,
      images: images,
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
      stock_num: stock_num,
      images: images,
      sale_attrs: sale_attrs,
      attrs: attrs
    }
  end

  def to_api_order
    {
      id: id,
      title: title,
      sku_code: sku_code,
      images: images
    }
  end
end
