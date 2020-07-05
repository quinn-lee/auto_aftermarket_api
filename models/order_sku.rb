# encoding: utf-8
# 订单包含的SKU表
class OrderSku < ActiveRecord::Base
  def to_api_order
    {
      order_no: order_no,
      service_fee: service_fee,
      quantity: quantity,
      price: price
    }
  end
end
