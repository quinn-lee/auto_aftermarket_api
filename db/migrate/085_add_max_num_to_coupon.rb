class AddMaxNumToCoupon < ActiveRecord::Migration[5.1]
  def self.up
    change_table :coupons do |t|
      t.integer :max_num
    end
  end

  def self.down
    change_table :coupons do |t|
      t.remove :max_num
    end
  end
end
