class CreateDistOrders < ActiveRecord::Migration[5.1]
  def self.up
    create_table :dist_orders do |t|
      t.integer :order_id
      t.integer :dist_agent_id
      t.string :sku_info
      t.integer :customer_id
      t.integer :merchant_id
      t.decimal :pay_amount, :precision => 10, :scale => 2
      t.decimal :commission, :precision => 10, :scale => 2
      t.datetime :pay_time
      t.datetime :complete_time
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :dist_orders
  end
end
