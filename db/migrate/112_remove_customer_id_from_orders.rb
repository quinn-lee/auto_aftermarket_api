class RemoveCustomerIdFromOrders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.remove :customer_id
    end
  end

  def self.down
    change_table :orders do |t|
      t.integer :customer_id
    end
  end
end
