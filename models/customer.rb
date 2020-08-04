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
    DistOrder.where(merchant_id: merchant.id).where(dist_agent_id: id)
  end

  # 可提现金额
  def can_withdraw_money(merchant)
    all_withdraw_money = dist_orders(merchant).where("complete_time <= '#{(Time.now - 7.days).strftime('%F %T')}'").each.sum(&:commission)
    withdrawed_money = Withdraw.where(merchant_id: merchant.id, customer_id: id).where.not(status: 2).each.sum(&:amount)
    all_withdraw_money - withdrawed_money
  end

  # 上月提现金额
  def last_month_withdraw(merchant)
    Withdraw.where(merchant_id: merchant.id, customer_id: id).where.not(status: 2).where("app_date >= '#{Date.today.last_month.at_beginning_of_month.strftime("%F %T")}'").where("app_date < '#{Date.today.at_beginning_of_month.strftime("%F %T")}'").each.sum(&:amount)
  end

  # 成交订单
  def paid_orders
    orders.where.not(status: ['unpaid','delete','cancelled'])
  end

  # 已完成订单
  def done_orders
    orders.where(status: ['done'])
  end

  # 已发展客户数
  def dist_customers
    Customer.where(dist_agent_id: id)
  end

  # 佣金比例
  def dist_percent
    ds = DistSetting.first
    if role_id == 1
      ds.try{|ds| ds.sales_percent } || 0
    elsif role_id == 2
      ds.try{|ds| ds.dist_percent } || 0
    else
      0
    end
  end

  # 是否可申请成为分销员
  def can_dist_apply?
    ds = DistSetting.first  #TODO 需要加上merchant_id的条件搜索
    (done_orders.each.sum(&:pay_amount) >= ds.amount_limit) or (dist_customers.count >= ds.number_limit)
  end

  def role_id_t
    if app_status == 1
      role_id
    else
      nil
    end
  end

end
