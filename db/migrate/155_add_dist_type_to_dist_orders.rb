class AddDistTypeToDistOrders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :dist_orders do |t|
      t.string :dist_type
    end
  end

  def self.down
    change_table :dist_orders do |t|
      t.remove :dist_type
    end
  end
end
