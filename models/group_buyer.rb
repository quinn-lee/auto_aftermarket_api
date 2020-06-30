class GroupBuyer < ActiveRecord::Base
  belongs_to :group,   :class_name => 'Group'

  scope :purchased,  lambda { where.not(status: 0) }

  STATUS = {
    1 => '完成',
    0 => '取消'
  }.stringify_keys
end
