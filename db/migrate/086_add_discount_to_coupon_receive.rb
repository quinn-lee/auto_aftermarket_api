class AddDiscountToCouponReceive < ActiveRecord::Migration[5.1]
  def self.up
    change_table :coupon_receives do |t|
      t.decimal :discount, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :coupon_receives do |t|
      t.remove :discount, :precision => 10, :scale => 2
    end
  end
end
