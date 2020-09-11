# encoding: utf-8
# 实付表
class OutlayReal < ActiveRecord::Base
  belongs_to :outlay, :class_name => 'Outlay'

  after_save do
    outlay.save  # 同步更新 outlay.paid_amount
  end

  after_destroy do
    outlay.save
  end
end
