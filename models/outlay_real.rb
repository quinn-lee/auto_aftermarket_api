# encoding: utf-8
# 实付表
class OutlayReal < ActiveRecord::Base
  belongs_to :outlay, :class_name => 'Outlay'
  has_many :cash_flows, :class_name => 'CashFlow', :dependent => :destroy

  after_save do
    outlay.save  # 同步更新 outlay.paid_amount
    CashFlow.create!(merchant_id: self.merchant_id, outlay_real_id: self.id, subject: "outlay", transaction_date: Time.now, amount: -self.paid_amount)
  end

  after_destroy do
    outlay.save
    cash_flows.delete_all
  end
end
