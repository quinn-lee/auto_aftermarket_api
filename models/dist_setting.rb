# encoding: utf-8
# 分销配置表
class DistSetting < ActiveRecord::Base
  validates :sales_percent, :dist_percent, :spu_percent, :info_service_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :amount_limit, numericality: {greater_than_or_equal_to: 0}
  validates :number_limit, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
