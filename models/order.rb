# encoding: utf-8
# 订单表
class Order < ActiveRecord::Base

  has_many :sub_orders, :class_name => 'SubOrder', :dependent => :destroy
  has_many :dist_orders, :class_name => 'DistOrder', :dependent => :destroy
  has_many :order_skus, :class_name => 'OrderSku', :dependent => :destroy
  has_many :comments, :class_name => 'Comment', :dependent => :destroy
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :account,   :class_name => 'Account'
  has_one :coupon_log, :class_name => 'CouponLog', :dependent => :destroy
  has_one :group_buyer, :class_name => 'GroupBuyer', :dependent => :destroy
  has_one :seckill_buyer, :class_name => 'SeckillBuyer', :dependent => :destroy

  after_save :update_dist_orders

  STATUS = {
    "unpaid" => '待付款',
    "paid" => '已付款待采购',
    "received" => '采购完成待发货',
    "appointing" => '待预约',
    "delivered" => '已发货待收货',
    "appointed" => '已预约待安装',
    "done" => '已完成',
    "delete" => '已删除',
    "cancelling" => '申请取消待审核',
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
    return false if status != "received" && status != "appointing" && status != "paid"
    if order_type == "group" # 团购需要判断是否已成团
      return false if group_buyer.group.status == 2  #已成团不可取消
    end
    return true
  end

  def do_cancel(refund_amount=nil)
    if refund_amount.present?
      update!(status: "cancelled", cancel_time: Time.now, refund_amount: refund_amount)
    else
      update!(status: "cancelled", cancel_time: Time.now, refund_amount: pay_amount)
    end
    if order_type == "group" && group_buyer.present?
      group_buyer.update!(status: 0)
    end
    if order_type == "seckill" && seckill_buyer.present?
      seckill_buyer.update!(status: 0)
    end
    sub_orders.update(status: "cancelled")
  end

  def do_cancel_reject(reject_reason)
    update!(status: sub_orders.last.status, reject_reason: reject_reason)
  end

  def order_reservation
    OrderReservation.find_by(order_no: order_no)
  end

  def reservation_time
    if order_reservation.present?
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
      old_pay_amount: old_pay_amount,
      #reject_reason: reject_reason,
      amount: amount,
      refund_amount: refund_amount,
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
      can_cancel: can_cancel?,
      sub_orders: sub_orders.map(&:to_api)
    }
    return h
  end

  def delivery_address
    if delivery_info.present?
      "#{delivery_info['province']}#{delivery_info['city']}#{delivery_info['district']} #{delivery_info['address']}  #{delivery_info['name']} #{delivery_info['mobile']}"
    end
  end
  def delivery_address_s
    if delivery_info.present?
      "#{delivery_info['province']}#{delivery_info['city']}#{delivery_info['district']} #{delivery_info['address']}"
    end
  end
  def contact_info_s
    if contact_info.present?
      "#{contact_info['name']} #{contact_info['mobile']}"
    end
  end

  # 发货单文件路径
  def order_file_path
    dir_path = "public/uploads/orders/#{self.created_at.strftime("%y%m%d")}"
    FileUtils.mkdir_p dir_path unless Dir.exist? dir_path
    return "#{dir_path}/#{order_no}.pdf"
  end


  # 订单状态修改后，根据订单状态回调产生分销订单数据
  def update_dist_orders
    t_sku = TSku.where(id: OrderSku.where(order_no: order_no).map(&:t_sku_id)).first
    ds = DistSetting.first
    if status == "paid" && dist_orders.blank?#插入分销订单数据
      # 客户介绍人
      if account.dist_agent_id.present?
        dist_agent = Account.find(account.dist_agent_id)
        percent = BigDecimal.new(dist_agent.dist_percent.to_s)
        commission = BigDecimal.new(sprintf("%.2f", (pay_amount * percent).to_s))
        # 分销金额>0 并且开启了分销，才插入分销订单数据
        #if commission > BigDecimal.new("0") && dist_orders.blank? && ds.dist_switch
        if ds.dist_switch
          DistOrder.create(dist_percent: percent, dist_type: "客户介绍人", order_id: id, dist_agent_id: dist_agent.id, sku_info: t_sku.t_spu.t_category.name, account_id: account_id, merchant_id: merchant_id, pay_amount: pay_amount, commission: commission, pay_time: pay_time, complete_time: nil)
        end
      end
      # 服务资讯人
      if account.info_service_id.present?
        dist_agent = Account.find(account.info_service_id)
        percent = BigDecimal.new((ds.try{|ds| ds.info_service_percent } || 0).to_s)
        commission = BigDecimal.new(sprintf("%.2f", (pay_amount * percent).to_s))
        # 分销金额>0 并且开启了分销，才插入分销订单数据
        #if commission > BigDecimal.new("0") && dist_orders.blank? && ds.dist_switch
        if ds.dist_switch
          DistOrder.create(dist_percent: percent, dist_type: "服务资讯人", order_id: id, dist_agent_id: dist_agent.id, sku_info: t_sku.t_spu.t_category.name, account_id: account_id, merchant_id: merchant_id, pay_amount: pay_amount, commission: commission, pay_time: pay_time, complete_time: nil)
        end
      end
      # 商品促销人
      order_skus.each do |order_sku|
        if order_sku.dist_agent_id.present?
          dist_agent = Account.find(order_sku.dist_agent_id)
          percent = BigDecimal.new((ds.try{|ds| ds.spu_percent } || 0).to_s)
          if order_sku.t_sku.t_spu.dist_percent.present?
            percent = BigDecimal.new(order_sku.t_sku.t_spu.dist_percent.to_s)
          end
          this_amount = BigDecimal.new(order_sku.price.to_s)*BigDecimal.new(order_sku.quantity.to_s)
          all_amount = order_skus.each.sum{|os| BigDecimal.new(os.price.to_s)*BigDecimal.new(os.quantity.to_s)}
          commission = BigDecimal.new(sprintf("%.2f", (pay_amount * percent * (this_amount/all_amount)).to_s))
          # 分销金额>0 并且开启了分销，才插入分销订单数据
          if ds.dist_switch
            DistOrder.create(dist_percent: percent, dist_type: "商品促销人", order_id: id, dist_agent_id: dist_agent.id, sku_info: t_sku.t_spu.t_category.name, account_id: account_id, merchant_id: merchant_id, pay_amount: BigDecimal.new(sprintf("%.2f", (pay_amount*this_amount/all_amount).to_s)), commission: commission, pay_time: pay_time, complete_time: nil)
          end
        end
      end
    elsif ['unpaid','delete','cancelled'].include? status #删除分销订单数据
      dist_orders.delete_all
    elsif status == "done" #更新分销订单数据
      dist_orders.update_all(complete_time: Time.now)
    end
  end


  # 订阅消息 发货通知
  def delivery_subscribe
    code,body=WebFunctions.method_url_call("get","https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Settings.wechat.appId}&secret=#{Settings.wechat.appSecret}",{},"JSON")
    if code!="200"
      logger.info("call api weixin expection , [#{code}]")
      raise "call api weixin timeout,please try again"
    else
      res=JSON.parse body
      if res["errcode"].present?
        raise res['errmsg']
      else
        access_token = res['access_token']
        t_sku = OrderSku.where(id: sub_orders.find_by(sub_type: "delivery").order_sku_ids).first.t_sku
        data = {
          "character_string1"=>{value: order_no[0..31]},
          "character_string2"=>{value: (delivery_info['shpmt_num'].to_s)[0..31]},
          "thing3"=>{value: (t_sku.present? ? t_sku.title : "")[0..19]},
          "thing4"=>{value: "您的订单已发货"}
        }
        param = {
          touser: account.openid,
          template_id: "PRP-auu9CmP6bQF3lEySj3E6OI3SSo5Dz3IxDQVJrdU",
          page: "/pages/orders/show?id=#{id}",
          data: data,
          miniprogram_state: "trial"
        }
        code,body=WebFunctions.method_url_call("post","https://api.weixin.qq.com/cgi-bin/message/subscribe/send?access_token=#{access_token}",param,"JSON")
        if code!="200"
          logger.info("call api subscribe expection , [#{code}]")
          raise "call api subscribe timeout,please try again"
        else
          logger.info("call api subscribe success")
        end
      end
    end
  end

  # 订阅消息 预约提醒
  def appoint_subscribe
    code,body=WebFunctions.method_url_call("get","https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Settings.wechat.appId}&secret=#{Settings.wechat.appSecret}",{},"JSON")
    if code!="200"
      logger.info("call api weixin expection , [#{code}]")
      raise "call api weixin timeout,please try again"
    else
      res=JSON.parse body
      if res["errcode"].present?
        raise res['errmsg']
      else
        access_token = res['access_token']
        data = {
          "character_string1"=>{value: order_no[0..31]},
          "thing5"=>{value: "您的订单商品已备齐，请您尽快预约安装时间"}
        }
        param = {
          touser: account.openid,
          template_id: "HeP4mRcMWyUREX-enXlcYYzeAZZ1ltgguxG1-KwvfU0",
          page: "/pages/orders/show?id=#{id}",
          data: data,
          miniprogram_state: "trial"
        }
        code,body=WebFunctions.method_url_call("post","https://api.weixin.qq.com/cgi-bin/message/subscribe/send?access_token=#{access_token}",param,"JSON")
        if code!="200"
          logger.info("call api subscribe expection , [#{code}]")
          raise "call api subscribe timeout,please try again"
        else
          logger.info("call api subscribe success")
        end
      end
    end
  end
end
