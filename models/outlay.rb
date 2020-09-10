# encoding: utf-8
# 应付表
class Outlay < ActiveRecord::Base
  has_many :outlay_reals, :class_name => 'OutlayReal', :dependent => :destroy

end
