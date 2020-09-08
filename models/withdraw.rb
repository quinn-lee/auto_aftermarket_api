# encoding: utf-8
# 佣金提现表

class Withdraw < ActiveRecord::Base
  belongs_to :account,   :class_name => 'Account'

  STATUS = {
    0 => '申请提现',
    1 => '已打款',
    2 => '审核未通过'
  }.stringify_keys

  def to_api
    {
      app_date: app_date.try{|ad| ad.strftime("%F %T")},
      pay_date: pay_date.try{|pd| pd.strftime("%F %T")},
      amount: amount,
      status: status,
      account_no: account_no,
      wechat_no: wechat_no
    }
  end
end
