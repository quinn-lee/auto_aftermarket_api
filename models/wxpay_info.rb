class WxpayInfo < ActiveRecord::Base

  def after_paid
    if order = Order.find_by(order_no: order_no)
      return if order.status != "unpaid"
      order.update!(status: "paid", pay_way: "wechat", pay_time: Time.now, tx_num: transaction_id)

      order_skus = OrderSku.where(order_no: order.order_no)
      if order.order_type == "maintenance" #维修保养时，只有一个子订单
        SubOrder.create!(order_id: order.id, sub_type: "install", order_sku_ids: order_skus.map(&:id))
      elsif order.order_type == "purchase" #根据是否有到店安装的商品进行拆分订单
        install_list = []
        delivery_list = []
        order_skus.each do |order_sku|
          if order_sku.service_fee.present? && order_sku.service_fee.has_key?('到店安装')
            install_list << order_sku.id
          else
            delivery_list << order_sku.id
          end
        end
        SubOrder.create!(order_id: order.id, sub_type: "install", order_sku_ids: install_list) if install_list.present?
        SubOrder.create!(order_id: order.id, sub_type: "delivery", order_sku_ids: delivery_list) if delivery_list.present?
      end
    end
  end
end
