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
