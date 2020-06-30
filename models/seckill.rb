class Seckill < ActiveRecord::Base
  validates :title, :detail, :merchant_id, :seckill_price, :t_sku_id, :begin_time, :end_time, :num, presence: true
end
