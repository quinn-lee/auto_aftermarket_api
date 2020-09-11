# encoding: utf-8
# 应收表
class Income < ActiveRecord::Base
  has_many :income_reals, :class_name => 'IncomeReal', :dependent => :destroy

  before_validation :setup, :on => [:create, :update]

  def can_edit?
    true
  end

  def can_delete?
    paid_amount.to_f == 0
  end

  private
  def setup
    self.paid_amount = income_reals.sum(:paid_amount)  # 计算实收总额
  end
end
