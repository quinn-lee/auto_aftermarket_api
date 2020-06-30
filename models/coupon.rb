class Coupon < ActiveRecord::Base
  validates :title, :remarks, :merchant_id, :money, :full_money, :begin_time, :end_time,  presence: true
end
