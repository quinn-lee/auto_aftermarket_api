# encoding: utf-8
# 商品收藏表
class Favorite < ActiveRecord::Base

  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :account,   :class_name => 'Account'
  belongs_to :t_sku,   :class_name => 'TSku'



end
