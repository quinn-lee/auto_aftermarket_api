# encoding: utf-8
# 团购购买记录
class GroupBuyer < ActiveRecord::Base
  belongs_to :group,   :class_name => 'Group'
  belongs_to :order,   :class_name => 'Order'
  belongs_to :account, :class_name => 'Account'

  scope :purchased,  lambda { where.not(status: 0) }

  STATUS = {
    1 => '完成',
    0 => '取消'
  }.stringify_keys
end
