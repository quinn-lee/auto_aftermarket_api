class SeckillBuyer < ActiveRecord::Base
  belongs_to :seckill,   :class_name => 'Seckill'
  belongs_to :order,   :class_name => 'Order'

  scope :purchased,  lambda { where.not(status: 0) }

  STATUS = {
    1 => '完成',
    0 => '取消'
  }.stringify_keys

end
