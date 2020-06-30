class Merchant < ActiveRecord::Base
  has_many :shops, :class_name => 'Shop', :dependent => :destroy
  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy
  has_many :t_skus, :class_name => 'TSku', :dependent => :destroy
  has_many :orders, :class_name => 'Order', :dependent => :destroy
  has_many :accounts, :class_name => 'Account', :dependent => :destroy

  has_many :groups, :class_name => 'Group', :dependent => :destroy
  has_many :coupons, :class_name => 'Coupon', :dependent => :destroy
  has_many :seckills, :class_name => 'Seckill', :dependent => :destroy
end
