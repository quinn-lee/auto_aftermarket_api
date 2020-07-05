# encoding: utf-8
# 客户浏览记录
class PageView < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Customer'

end
