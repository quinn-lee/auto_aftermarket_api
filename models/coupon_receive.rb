# encoding: utf-8
# 优惠券领取记录
class CouponReceive < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Account'
  belongs_to :coupon,   :class_name => 'Coupon'

  STATUS = {
    0 => '已领取未使用',
    1 => '已使用',
    2 => '已过期'
  }.stringify_keys

  def to_api
    {
      id: id,
      status: STATUS[status.to_s],
      coupon: coupon.to_api
    }
  end
end
