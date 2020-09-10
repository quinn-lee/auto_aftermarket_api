class AddOrderIdToOrderSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :order_skus do |t|
      t.integer :order_id
    end
  end

  def self.down
    change_table :order_skus do |t|
      t.remove :order_id
    end
  end
end
