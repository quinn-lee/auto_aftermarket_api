class CreateOrders < ActiveRecord::Migration[5.1]
  def self.up
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :merchant_id
      t.datetime :order_date
      t.string :order_no
      t.decimal :amount, :precision => 10, :scale => 2
      t.string :order_name
      t.string :order_type
      t.decimal :pay_amount, :precision => 10, :scale => 2
      t.string :pay_way
      t.datetime :pay_time
      t.string :tx_num
      t.string :status
      t.datetime :cancel_time
      t.string :cancel_reason
      t.datetime :reservation_time
      t.integer :shop_id
      t.jsonb :delivery_info
      t.jsonb :contact_info
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :orders
  end
end
