class AddDistPercentToDistOrders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :dist_orders do |t|
      t.decimal :dist_percent, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :dist_orders do |t|
      t.remove :dist_percent
    end
  end
end
