# encoding: utf-8
# 微信支付请求
class WxpayInfo < ActiveRecord::Base

  def after_paid
    if order = Order.find_by(order_no: order_no)
      return if order.status != "unpaid"
      order.update!(status: "paid", pay_way: "wechat", pay_time: Time.now, tx_num: transaction_id)

      order_skus = OrderSku.where(order_no: order.order_no)
      if order_skus.where("lack_quantity > 0").count == 0 # 不缺货时，更新订单状态为可发货或可预约
        order.update!(status: "received")
      end
      if order.order_type == "maintenance" #维修保养时，只有一个子订单
        SubOrder.create!(order_id: order.id, sub_type: "install", order_sku_ids: order_skus.map(&:id))
      else #根据是否有到店安装的商品进行拆分订单
        install_list = []
        delivery_list = []
        order_skus.each do |order_sku|
          if order_sku.service_fee.present? && order_sku.service_fee.has_key?('到店安装')
            install_list << order_sku.id
          else
            delivery_list << order_sku.id
          end
        end
        if install_list.present?
          so = SubOrder.create!(order_id: order.id, sub_type: "install", order_sku_ids: install_list, status: order.status)
          if order.status == "received"
            order.update!(status: "appointing") #更新为待预约
            so.update!(status: "appointing") #更新为待预约
            order.appoint_subscribe #订阅消息
          end
        end
        SubOrder.create!(order_id: order.id, sub_type: "delivery", order_sku_ids: delivery_list, status: order.status) if delivery_list.present?
      end

      # 如果有使用优惠券，更新优惠券状态
      if order.coupon_log.present?
        order.coupon_log.update!(status: 1)
      end
    end
  end
end
