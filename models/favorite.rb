# encoding: utf-8
# 商品收藏表
class Favorite < ActiveRecord::Base

  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :customer,   :class_name => 'Customer'
  belongs_to :t_sku,   :class_name => 'TSku'

  

end
