# encoding: utf-8
# 客户表+后台账号表，每个商户有多个管理账户
class Account < ActiveRecord::Base
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :shop,   :class_name => 'Shop'

  has_many :orders, :class_name => 'Order', :dependent => :destroy
  has_many :shares, :class_name => 'Share', :dependent => :destroy
  has_many :page_views, :class_name => 'PageView', :dependent => :destroy
  has_many :sku_views, :class_name => 'SkuView', :dependent => :destroy
  has_many :coupon_receives, :class_name => 'CouponReceive', :dependent => :destroy
  has_many :group_buyers, :class_name => 'GroupBuyer', :dependent => :destroy
  has_many :seckill_buyers, :class_name => 'SeckillBuyer', :dependent => :destroy
  has_many :favorites, :class_name => 'Favorite', :dependent => :destroy
  has_many :comments, :class_name => 'Comment', :dependent => :destroy
  has_many :agent_changes, :class_name => 'AgentChange', :dependent => :destroy

  attr_accessor :password, :password_confirmation

  # Validations
  validates_presence_of     :role_id
  #validates_presence_of     :email,                      :if => :admin_user
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required
  #validates_length_of       :email,    :within => 3..100,:if => :admin_user
  #validates_uniqueness_of   :email,    :case_sensitive => false, :if => :admin_user
  #validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => :admin_user
  #validates_format_of       :role,     :with => /[A-Za-z]/

  # Callbacks
  before_save :encrypt_password, :if => :password_required

  APPSTATUS = {
    0 => '待审核',
    1 => '审核通过',
    2 => '审核未通过'
  }.stringify_keys

  mount_uploader :wx_barcode, FileUploader
  mount_uploader :avatar, FileUploader

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = where("lower(email) = lower(?)", email).first if email.present?
    account && account.has_password?(password) ? account : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  # 角色名称
  def role
    if role_id.present? && r = Role.find(role_id)
      return r.name
    end
  end

  # 分销员信息
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
    Account.where(dist_agent_id: id)
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

  # 对应分销员
  def agent
    if dist_agent_id.present?
      Account.find(dist_agent_id)
    end
  end

  private

  def encrypt_password
    value = ::BCrypt::Password.create(password)
    value = value.force_encoding(Encoding::UTF_8) if value.encoding == Encoding::ASCII_8BIT
    self.crypted_password = value
  end

  def password_required
    crypted_password.blank? || password.present?
  end

  def admin_user
    role_id > 3
  end
end
