# encoding: utf-8
# 分销订单
class DistOrder < ActiveRecord::Base

  belongs_to :order,   :class_name => 'Order'
  belongs_to :customer, :class_name => 'Customer'

  def to_api
    {
      sku_info: sku_info,
      customer_nickname: (self.customer.wechat_info || {})['nickName'],
      pay_amount: pay_amount,
      commission: commission,
      pay_time: pay_time.try{|pt| pt.strftime("%F %T")}
    }
  end
end
