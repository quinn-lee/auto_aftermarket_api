class CouponLog < ActiveRecord::Base
  belongs_to :order,   :class_name => 'Order'

  STATUS = {
    1 => '支付成功', #支付成功回调后修改为该状态
    0 => '已记录'
  }.stringify_keys
end
