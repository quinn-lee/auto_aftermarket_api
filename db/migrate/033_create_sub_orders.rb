class CreateSubOrders < ActiveRecord::Migration[5.1]
  def self.up
    create_table :sub_orders do |t|
      t.integer :order_id
      t.string :sub_type
      t.jsonb :order_sku_ids
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sub_orders
  end
end
