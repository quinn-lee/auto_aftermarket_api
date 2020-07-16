class AddShopIdToAccount < ActiveRecord::Migration[5.1]
  def self.up
    change_table :accounts do |t|
      t.integer :shop_id
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :shop_id
    end
  end
end
