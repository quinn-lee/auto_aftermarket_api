# encoding: utf-8
# 属性值
class TAttrvalue < ActiveRecord::Base
  belongs_to :t_attribute,   :class_name => 'TAttribute'
end
