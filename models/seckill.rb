class Seckill < ActiveRecord::Base
  validates :title, :detail, :merchant_id, :seckill_price, :t_sku_id, :begin_time, :end_time, :num, presence: true

  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :t_sku,   :class_name => 'TSku'

  has_many :seckill_buyers, :class_name => 'SeckillBuyer', :dependent => :destroy

  STATUS = {
    1 => '上架',
    0 => '下架',
    2 => '结束'
  }.stringify_keys

  def to_api
    {
      id: id,
      title: title,
      detail: detail,
      num: num,
      status: STATUS[status.to_s],
      begin_time: begin_time.try{|bt| bt.strftime("%F %T")},
      end_time: end_time.try{|et| et.strftime("%F %T")},
      seckill_price: seckill_price,
      remaining_num: remaining_num,
      sku: t_sku.to_api_simple
    }
  end
end
