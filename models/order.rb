class Order < ActiveRecord::Base

  def gen_order_no
    r=ActiveRecord::Base.connection.execute("select nextval('order_no_seq')")
    "#{r[0]['nextval']}#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end

  def to_api
    oss = OrderSku.where(order_no: order_no)
    items = []
    oss.map(&:name).uniq.each do |os_name|
      skus = []
      oss.where(name: os_name).each do |os|
        skus << TSku.find(os.t_sku_id).to_api_order.merge(os.to_api_order)
      end
      items << {name: os_name, skus: skus}
    end

    h = {
      id: id,
      order_date: order_date.try{|o| o.strftime("%F")},
      order_no: order_no,
      order_type: order_type,
      pay_amount: pay_amount,
      amount: amount,
      status: status,
      delivery_info: delivery_info,
      contact_info: contact_info,
      items: items
    }
    return h
  end
end
