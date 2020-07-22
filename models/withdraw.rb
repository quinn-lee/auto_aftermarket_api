# encoding: utf-8
# 佣金提现表

class Withdraw < ActiveRecord::Base
  STATUS = {
    0 => '申请提现',
    1 => '审核通过已打款',
    2 => '审核未通过'
  }.stringify_keys

  def to_api
    {
      app_date: app_date.strftime("%F %T"),
      amount: amount,
      status: status
    }
  end
end
