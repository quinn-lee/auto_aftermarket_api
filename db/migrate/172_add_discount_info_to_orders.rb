class AddDiscountInfoToOrders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.jsonb :discount_info, default: []
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :discount_info
    end
  end
end
