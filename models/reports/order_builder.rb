# encoding: utf-8
require "prawn/measurement_extensions"


class OrderBuilder < Prawn::Document
  include Prawn

  def initialize
      super(:page_size => "A4", :page_layout => :portrait, :margin => [0.5.send(:cm), 0.5.send(:cm), 0.5.send(:cm), 0.5.send(:cm)])
  end

  def build(order)
    bold_path="lib/ttfs/Arial_Narrow_Bold.TTF"
    dvs_path = "lib/ttfs/DejaVuSans.ttf"
    ele_path = "lib/ttfs/Elephant.ttf"
    hy_path = "lib/ttfs/hya6gb3.ttf"
    font(hy_path) do
      text "发货单", :size => 18, :align => :center
      move_down 20
      text "订单号.   #{order.order_no}", :size => 14, :align => :left
      text "收件人.   #{(order.delivery_info||{})['name']}", :size => 14, :align => :left
      text "电话.     #{(order.delivery_info||{})['mobile']}", :size => 14, :align => :left
      text "地址.     #{order.delivery_address_s}", :size => 14, :align => :left
      move_down 30
      data_detail = [["SKU代码", "商品名称", "数量"]]
      if delivery_order = order.sub_orders.find_by(sub_type: "delivery")
        OrderSku.where(id: delivery_order.order_sku_ids).each do |order_sku|
          data_detail << ["#{order_sku.t_sku.sku_code}", "#{order_sku.t_sku.title}", "#{order_sku.quantity}"]
        end
        table data_detail, :width => 560, :column_widths => [120, 340,100], :cell_style => { :size => 10} do
            cells.padding = 2
            cells.borders = [:top,:bottom, :right, :left]
        end
      end
    end


    file_path = order.order_file_path
    render_file(file_path)
    file_path
  end


end
