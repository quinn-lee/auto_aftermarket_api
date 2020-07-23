# encoding: utf-8
# 客户表

class Customer < ActiveRecord::Base
  has_many :orders, :class_name => 'Order', :dependent => :destroy
  has_many :shares, :class_name => 'Share', :dependent => :destroy
  has_many :page_views, :class_name => 'PageView', :dependent => :destroy
  has_many :sku_views, :class_name => 'SkuView', :dependent => :destroy
  has_many :coupon_receives, :class_name => 'CouponReceive', :dependent => :destroy
  has_many :group_buyers, :class_name => 'GroupBuyer', :dependent => :destroy
  has_many :seckill_buyers, :class_name => 'SeckillBuyer', :dependent => :destroy
  has_many :favorites, :class_name => 'Favorite', :dependent => :destroy

  belongs_to :role,   :class_name => 'Role'

  APPSTATUS = {
    0 => '待审核',
    1 => '审核通过',
    2 => '审核未通过'
  }.stringify_keys

  mount_uploader :wx_barcode, FileUploader
  mount_uploader :avatar, FileUploader

  def to_agent_api
    {
      id: id,
      name: name,
      mobile: mobile,
      token: token,
      email: email,
      wx_barcode: wx_barcode.present? ? wx_barcode.url : nil,
      avatar: avatar.present? ? avatar.url : nil,
      wechat_info: wechat_info
    }
  end

  # 分销订单
  def dist_orders(merchant)
    Order.where(merchant_id: merchant.id).where.not(status: ['unpaid','delete','cancelled']).where(customer_id: Customer.where(dist_agent_id: id).map(&:id))
  end

  # 可提现金额
  def can_withdraw_money(merchant, percent)
    all_withdraw_money = percent * dist_orders(merchant).where(status: "done").where("pay_time <= '#{(Time.now - 7.days).strftime('%F %T')}'").each.sum(&:pay_amount)
    withdrawed_money = Withdraw.where(merchant_id: merchant.id, customer_id: id).where.not(status: 2).each.sum(&:amount)
    all_withdraw_money - withdrawed_money
  end

  # 上月提现金额
  def last_month_withdraw(merchant)
    Withdraw.where(merchant_id: merchant.id, customer_id: id).where.not(status: 2).where("app_date >= '#{Date.today.last_month.at_beginning_of_month.strftime("%F %T")}'").where("app_date < '#{Date.today.at_beginning_of_month.strftime("%F %T")}'").each.sum(&:amount)
  end

  def paid_orders
    orders.where.not(status: ['unpaid','delete','cancelled'])
  end

  def done_orders
    orders.where(status: ['done'])
  end

  def dist_customers
    Customer.where(dist_agent_id: id)
  end

end
