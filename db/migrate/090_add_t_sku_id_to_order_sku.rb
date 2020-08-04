class AddTSkuIdToOrderSku < ActiveRecord::Migration[5.1]
  def self.up
    change_table :order_skus do |t|
      t.integer :t_sku_id
    end
  end

  def self.down
    change_table :order_skus do |t|
      t.remove :t_sku_id
    end
  end
end
