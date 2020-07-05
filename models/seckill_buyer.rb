# encoding: utf-8
# 秒杀购买记录
class SeckillBuyer < ActiveRecord::Base
  belongs_to :seckill,   :class_name => 'Seckill'
  belongs_to :order,   :class_name => 'Order'
  belongs_to :customer, :class_name => 'Customer'

  scope :purchased,  lambda { where.not(status: 0) }

  STATUS = {
    1 => '完成',
    0 => '取消'
  }.stringify_keys

end
