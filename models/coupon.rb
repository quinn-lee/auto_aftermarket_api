class Coupon < ActiveRecord::Base
  validates :title, :remarks, :merchant_id, :money, :full_money, :end_time,  presence: true

  belongs_to :merchant,   :class_name => 'Merchant'
  has_many :coupon_receives, :class_name => 'CouponReceive', :dependent => :destroy

  STATUS = {
    1 => '可领取',
    0 => '下架',
    2 => '已结束'
  }.stringify_keys

  def to_api
    {
      id: id,
      title: title,
      remarks: remarks,
      end_time: end_time.try{|et| et.strftime("%F %T")},
      money: money,
      full_money: full_money,
      status: STATUS[status.to_s]
    }
  end


end
