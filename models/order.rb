class Order < ActiveRecord::Base

  has_many :sub_orders, :class_name => 'SubOrder', :dependent => :destroy
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :customer,   :class_name => 'Customer'
  has_one :coupon_log, :class_name => 'CouponLog', :dependent => :destroy
  has_one :group_buyer, :class_name => 'GroupBuyer', :dependent => :destroy

  def gen_order_no
    r=ActiveRecord::Base.connection.execute("select nextval('order_no_seq')")
    "#{r[0]['nextval']}#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end

  def can_delete?
    ['unpaid', 'done'].include? status
  end

  # 仅在支付成功后，可取消
  def can_cancel?
    return false if status != "paid"
    if order_type == "group" # 团购需要判断是否已成团
      return false if group_buyer.group.status == 2  #已成团不可取消
    end
    return true
  end

  def do_cancel
    update!(status: "cancelled")
    if order_type == "group" && group_buyer.present?
      group_buyer.update!(status: 0)
    end
  end

  def reservation_time
    if order_reservation = OrderReservation.find_by(order_no: order_no)
      order_reservation.to_api
    end
  end

  def to_api
    oss = OrderSku.where(order_no: order_no)
    items = []
    oss.map(&:name).uniq.each do |os_name|
      skus = []
      oss.where(name: os_name).each do |os|
        skus << TSku.find(os.t_sku_id).to_api_order.merge(os.to_api_order)
      end
      items << {name: os_name, skus: skus}
    end
    need_hours = 1.5
    need_lift_hours = 0.5
    shop_info = {}
    if shop_id.present?
      shop_info = Shop.find(shop_id).to_api_simple
    end

    h = {
      id: id,
      order_date: order_date.try{|o| o.strftime("%F")},
      order_no: order_no,
      order_type: order_type,
      pay_amount: pay_amount,
      amount: amount,
      coupon_amount: coupon_log.present? ? coupon_log.coupon_amount : 0,
      group_buyer_id: group_buyer.present? ? group_buyer.id : nil,
      group: group_buyer.present? ? group_buyer.group.to_api : {},
      status: status,
      delivery_info: delivery_info,
      shop_info: shop_info,
      contact_info: contact_info,
      need_hours: need_hours,
      need_lift_hours: need_lift_hours,
      reservation_time: reservation_time,
      items: items,
      sub_orders: sub_orders.map(&:to_api)
    }
    return h
  end
end
