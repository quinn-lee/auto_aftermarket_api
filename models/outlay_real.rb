# encoding: utf-8
# 实付表
class OutlayReal < ActiveRecord::Base
  belongs_to :outlay,   :class_name => 'Outlay'

end
