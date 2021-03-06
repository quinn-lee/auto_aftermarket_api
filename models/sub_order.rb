# encoding: utf-8
# 子订单
class SubOrder < ActiveRecord::Base
  belongs_to :order,   :class_name => 'Order'

  SUBTYPE = {
    "install" => '安装',
    "delivery" => '寄送'
  }.stringify_keys

  def to_api
    oss = OrderSku.where(id: order_sku_ids)
    items = []
    oss.each do |os|
      items << TSku.find(os.t_sku_id).to_api_order.merge(os.to_api_order)
    end
    shop_info = {}
    if order.shop_id.present?
      shop_info = Shop.find(order.shop_id).to_api_simple
    end
    {
      sub_type: sub_type,
      shop_info: shop_info,
      delivery_info: order.delivery_info,
      contact_info: order.contact_info,
      status: status,
      items: items
    }
  end
end
