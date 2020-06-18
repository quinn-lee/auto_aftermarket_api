class Customer < ActiveRecord::Base
  has_many :orders, :class_name => 'Order', :dependent => :destroy
end
