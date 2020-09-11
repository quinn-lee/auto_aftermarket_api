# encoding: utf-8
# 应付表
class Outlay < ActiveRecord::Base
  has_many :outlay_reals, :class_name => 'OutlayReal', :dependent => :destroy

  before_validation :setup, :on => [:create, :update]

  def can_edit?
    true
  end

  def can_delete?
    paid_amount.to_f == 0
  end

  private
  def setup
    self.paid_amount = outlay_reals.sum(:paid_amount)  # 计算实收总额
  end
end
