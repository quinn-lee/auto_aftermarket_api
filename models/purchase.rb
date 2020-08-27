class Purchase < ActiveRecord::Base
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :account,   :class_name => 'Account'

  has_many :purchase_skus, :class_name => 'PurchaseSku', :dependent => :destroy

  after_create do
    create_purchase_skus!
  end

  def gen_purchase_no
    r=ActiveRecord::Base.connection.execute("select nextval('order_no_seq')")
    "P#{r[0]['nextval']}"
  end

  def create_purchase_skus!
    code_info.each do |code|
      if sku = TSku.find_by(sku_code: code['sku_code'])
        PurchaseSku.create!(purchase_id: id, t_sku_id: sku.id, current_stock: sku.stock_num, quantity: code['quantity'].to_i)
      end
    end
  end

  def update_lack_orders!
    order_skus = OrderSku.where("lack_quantity > 0").where("(SELECT orders.merchant_id FROM orders WHERE orders.order_no = order_skus.order_no) = #{merchant_id}")
    order_skus.order("created_at asc").each do |order_sku|
      tsku = order_sku.t_sku
      if order_sku.lack_quantity <= tsku.stock_num #实际库存数量够
        tsku.update!(stock_num: (tsku.stock_num||0)-order_sku.lack_quantity, available_num: (tsku.available_num||0)-order_sku.lack_quantity)
        order_sku.update!(lack_quantity: 0)
        if order = Order.find_by(order_no: order_sku.order_no)
          if order.status == 'paid'
            oskus = OrderSku.where(order_no: order.order_no)
            if oskus.where("lack_quantity > 0").count == 0 # 不缺货时，更新订单状态为可发货或可预约
              order.update!(status: "received")
              if install_order = order.sub_orders.find_by(sub_type: "install")
                install_order.update!(status: "appointing")
                order.update!(status: "appointing")
              end
              if delivery_order = order.sub_orders.find_by(sub_type: "delivery")
                delivery_order.update!(status: "received")
              end
            end
          end
        end
      end
    end
  end
end
