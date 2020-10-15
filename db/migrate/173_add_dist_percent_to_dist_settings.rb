class AddDistPercentToDistSettings < ActiveRecord::Migration[5.1]
  def self.up
    change_table :dist_settings do |t|
      t.decimal :deal_percent, precision: 10, scale: 2, default: 100
    end
  end

  def self.down
    change_table :dist_settings do |t|
      t.remove :deal_percent
    end
  end
end
