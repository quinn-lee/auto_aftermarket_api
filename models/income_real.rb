# encoding: utf-8
# 实收表
class IncomeReal < ActiveRecord::Base
  belongs_to :income, :class_name => 'Income'
  has_many :cash_flows, :class_name => 'CashFlow', :dependent => :destroy

  after_save do
    income.save  # 同步更新 income.paid_amount
    # 插入现金流量表
    CashFlow.create!(merchant_id: self.merchant_id, income_real_id: self.id, subject: "income", transaction_date: Time.now, amount: self.paid_amount)
  end

  after_destroy do
    income.save
    cash_flows.delete_all
  end
end
