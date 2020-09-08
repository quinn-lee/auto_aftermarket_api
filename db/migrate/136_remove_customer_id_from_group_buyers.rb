class RemoveCustomerIdFromGroupBuyers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :group_buyers do |t|
      t.remove :customer_id
    end
  end

  def self.down
    change_table :group_buyers do |t|
      t.integer :customer_id
    end
  end
end
