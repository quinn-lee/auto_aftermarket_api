# encoding: utf-8
# 实收表
class IncomeReal < ActiveRecord::Base
  belongs_to :income,   :class_name => 'Income'

end
