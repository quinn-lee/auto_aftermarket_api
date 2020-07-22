# encoding: utf-8
# 订单表
class Order < ActiveRecord::Base

  has_many :sub_orders, :class_name => 'SubOrder', :dependent => :destroy
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :customer,   :class_name => 'Customer'
  has_one :coupon_log, :class_name => 'CouponLog', :dependent => :destroy
  has_one :group_buyer, :class_name => 'GroupBuyer', :dependent => :destroy
  has_one :seckill_buyer, :class_name => 'SeckillBuyer', :dependent => :destroy

  STATUS = {
    "unpaid" => '待付款',
    "paid" => '已付款待采购',
    "received" => '采购完成待预约/发货',
    "delivered" => '已发货待收货',
    "appointed" => '已预约待安装',
    "done" => '已完成',
    "delete" => '已删除',
    "cancelled" => '已取消'
  }.stringify_keys

  ORDERTYPE = {
    "maintenance" => '维修保养',
    "purchase" => '自选商品',
    "group" => '团购',
    "seckill" => '秒杀'
  }.stringify_keys

  def gen_order_no
    r=ActiveRecord::Base.connection.execute("select nextval('order_no_seq')")
    "#{r[0]['nextval']}#{Time.now.strftime('%Y%m%d%H%M%S')}"
  end

  def can_delete?
    ['unpaid', 'done', 'cancelled'].include? status
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
    if order_type == "seckill" && seckill_buyer.present?
      seckill_buyer.update!(status: 0)
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

  def to_agent_api(percent)
    t_sku = TSku.where(id: OrderSku.where(order_no: order_no).map(&:t_sku_id)).first
    {
      sku_info: t_sku.t_spu.t_category.name,
      customer_nickname: (self.customer.wechat_info || {})['nickName'],
      pay_amount: pay_amount,
      commission: BigDecimal.new(sprintf("%.2f", (pay_amount * percent).to_s)),
      pay_time: pay_time.try{|pt| pt.strftime("%F %T")}
    }

  end

  def delivery_address
    if delivery_info.present?
      "#{delivery_info['province']}#{delivery_info['city']}#{delivery_info['district']} #{delivery_info['address']}  #{delivery_info['name']} #{delivery_info['mobile']}"
    end
  end
  def contact_info_s
    if contact_info.present?
      "#{contact_info['name']} #{contact_info['mobile']}"
    end
  end
end
