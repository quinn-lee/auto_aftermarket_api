# encoding: utf-8
# 优惠券
require 'rmagick'

class Coupon < ActiveRecord::Base
  validates :title, :remarks, :merchant_id, :ctype, :end_time,  presence: true
  validates :money, :full_money, numericality: true, if: :full_reduction?
  validates :max_num, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :discount, numericality: { greater_than: 0, less_than: 10 }, if: :discount_reduction?

  belongs_to :merchant,   :class_name => 'Merchant'
  has_many :coupon_receives, :class_name => 'CouponReceive', :dependent => :destroy

  after_save do
    self.to_img
  end

  STATUS = {
    1 => '可领取',
    0 => '下架',
    2 => '已结束'
  }.stringify_keys

  CTYPE = {
    1 => '满减券',
    #2 => '折扣券'
  }.stringify_keys

  def full_reduction?
    ctype == 1
  end

  def discount_reduction?
    ctype == 2
  end

  def to_api
    to_img unless File.exists? img_path
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
      status: STATUS[status.to_s],
      img_path: img_path
    }
  end

  def coupon_logs
    CouponLog.where(coupon_receive_id: coupon_receives.map(&:id))
  end

  def img_path
    dir = "public/uploads/coupon"
    Dir.mkdir dir unless Dir.exist? dir
    "#{dir}/#{id}.png"
  end

  def to_img
    if full_reduction?
      my_text="¥#{sprintf('%.2f', money)}"
      if money < BigDecimal.new("10")
        x_position = 220
      elsif money < BigDecimal.new("100")
        x_position = 180
      else
        x_position = 140
      end
    elsif discount_reduction?
      my_text="Dis. #{sprintf('%.2f', discount)}"
      x_position = 110
    else
      return
    end
    img =  Magick::Image.read('public/coupon.png').first
    copyright=Magick::Draw.new
    copyright.annotate(img,0,0,x_position,390,my_text) do #字的位置
      self.gravity = Magick::CenterGravity
      self.pointsize=126 #字体大小
      self.font_weight=Magick::BoldWeight
      self.fill='black' #颜色
      self.gravity=Magick::SouthEastGravity
      self.stroke = "none"
    end
    img=img.raise #浮雕效果
    img.write(img_path)
  end


end
