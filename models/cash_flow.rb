# encoding: utf-8
# 现金流量表
class CashFlow < ActiveRecord::Base
  belongs_to :outlay_real, :class_name => 'OutlayReal'
  belongs_to :income_real, :class_name => 'IncomeReal'
  belongs_to :order, :class_name => 'Order'

  SUBJECT = {
    "order" => '订单',
    "refund" => '退款',
    "income" => '其他收入',
    "outlay" => '其他支出',
    "commission" => '佣金',
  }.stringify_keys

  def show_no
    if order.present?
      order.order_no
    elsif outlay_real.present?
      outlay_real.outlay.contract_no
    elsif income_real.present?
      income_real.income.contract_no
    end
  end
end
