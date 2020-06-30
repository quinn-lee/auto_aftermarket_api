class CreateGroupBuyers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :group_buyers do |t|
      t.integer :customer_id
      t.integer :group_id
      t.integer :order_id
      t.integer :t_sku_id
      t.integer :group_quantity
      t.integer :status
      t.decimal :group_price, :precision => 10, :scale => 2
      t.decimal :group_amount, :precision => 10, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :group_buyers
  end
end
