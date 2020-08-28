class CreatePurchaseSkus < ActiveRecord::Migration[5.1]
  def self.up
    create_table :purchase_skus do |t|
      t.integer :purchase_id
      t.integer :t_sku_id
      t.integer :current_stock
      t.integer :quantity
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :purchase_skus
  end
end
