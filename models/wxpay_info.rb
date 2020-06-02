class WxpayInfo < ActiveRecord::Base

  def after_paid
    if order = Order.find_by(order_no: order_no)
      order.update!(status: "paid", pay_way: "wechat", pay_time: Time.now, tx_num: transaction_id)
    end
  end
end
