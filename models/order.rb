class Order < ActiveRecord::Base

  def to_api
    oss = OrderSku.where(order_no: order_no)
    items = []
    oss.map(&:name).uniq.each do |os_name|
      skus = []
      oss.where(name: os_name).each do |os|
        skus << Sku.find_by(sku_code: os.sku_code).to_api_order.merge(os.to_api_order)
      end
      items << {name: os_name, skus: skus}
    end

    h = {
      id: id,
      order_date: order_date.try{|o| o.strftime("%F")},
      order_no: order_no,
      amount: amount,
      status: status,
      items: items
    }
    return h
  end
end
