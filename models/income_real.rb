# encoding: utf-8
# 实收表
class IncomeReal < ActiveRecord::Base
  belongs_to :income, :class_name => 'Income'

  after_save do
    income.save  # 同步更新 income.paid_amount
  end

  after_destroy do
    income.save
  end
end
