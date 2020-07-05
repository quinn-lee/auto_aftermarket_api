# encoding: utf-8
# 预约
class OrderReservation < ActiveRecord::Base
  def to_api
    {
      order_no: order_no,
      booking_date: booking_date.try{|b| b.strftime("%F")},
      booking_time_from: booking_time_from.try{|b| b.strftime("%F %T")},
      booking_time_to: booking_time_to.try{|b| b.strftime("%F %T")}
    }
  end
end
