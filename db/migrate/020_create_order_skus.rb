class CreateOrderSkus < ActiveRecord::Migration[5.1]
  def self.up
    create_table :order_skus do |t|
      t.string :order_no
      t.string :name
      t.string :t_sku_id
      t.integer :quantity
      t.decimal :price, :precision => 8, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :order_skus
  end
end
