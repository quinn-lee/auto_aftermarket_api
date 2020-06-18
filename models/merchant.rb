class Merchant < ActiveRecord::Base
  has_many :shops, :class_name => 'Shop', :dependent => :destroy
  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy
  has_many :t_skus, :class_name => 'TSku', :dependent => :destroy
  has_many :orders, :class_name => 'Order', :dependent => :destroy
end
