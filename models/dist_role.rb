# encoding: utf-8
# 分销角色表
class DistRole < ActiveRecord::Base
  validates :name, presence: true
  validates :dist_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

end
