class OrderSku < ActiveRecord::Base
  def to_api_order
    {
      order_no: order_no,
      quantity: quantity,
      price: price
    }
  end
end
