class AddLackQuantityToOrderSku < ActiveRecord::Migration[5.1]
  def self.up
    change_table :order_skus do |t|
      t.integer :lack_quantity, default: 0
    end
  end

  def self.down
    change_table :order_skus do |t|
      t.remove :lack_quantity
    end
  end
end
