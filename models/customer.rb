class Customer < ActiveRecord::Base
  has_many :orders, :class_name => 'Order', :dependent => :destroy
  has_many :shares, :class_name => 'Share', :dependent => :destroy
  has_many :page_views, :class_name => 'PageView', :dependent => :destroy
  has_many :coupon_receives, :class_name => 'CouponReceive', :dependent => :destroy

end
