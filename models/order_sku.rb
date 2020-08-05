# encoding: utf-8
# 订单包含的SKU表
class OrderSku < ActiveRecord::Base
  belongs_to :t_sku,   :class_name => 'TSku'
  def to_api_order
    {
      order_no: order_no,
      service_fee: service_fee,
      quantity: quantity,
      price: price
    }
  end

  def to_api_comment
    order = Order.find_by(order_no: order_no)
    if order
      t_sku.to_api_order.merge({order_id: order.id})
    else
      t_sku.to_api_order
    end
  end
end
