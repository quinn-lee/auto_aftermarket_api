# encoding: utf-8
# 优惠券
class Coupon < ActiveRecord::Base
  validates :title, :remarks, :merchant_id, :ctype, :end_time,  presence: true
  validates :money, :full_money, numericality: true, if: :full_reduction?
  validates :max_num, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :discount, numericality: { greater_than: 0, less_than: 10 }, if: :discount_reduction?

  belongs_to :merchant,   :class_name => 'Merchant'
  has_many :coupon_receives, :class_name => 'CouponReceive', :dependent => :destroy

  STATUS = {
    1 => '可领取',
    0 => '下架',
    2 => '已结束'
  }.stringify_keys

  CTYPE = {
    1 => '满减券',
    2 => '折扣券'
  }.stringify_keys

  def full_reduction?
    ctype == 1
  end

  def discount_reduction?
    ctype == 2
  end

  def to_api
    {
      id: id,
      title: title,
      remarks: remarks,
      ctype: CTYPE[ctype.to_s],
      begin_time: begin_time.try{|bt| bt.strftime("%F %T")},
      end_time: end_time.try{|et| et.strftime("%F %T")},
      money: money,
      full_money: full_money,
      discount: discount,
      max_num: max_num,
      received_num: coupon_receives.count,
      spus: spus,
      status: STATUS[status.to_s]
    }
  end

  def coupon_logs
    CouponLog.where(coupon_receive_id: coupon_receives.map(&:id))
  end


end
