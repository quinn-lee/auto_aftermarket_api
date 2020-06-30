class CouponLog < ActiveRecord::Base
  belongs_to :order,   :class_name => 'Order'

end
