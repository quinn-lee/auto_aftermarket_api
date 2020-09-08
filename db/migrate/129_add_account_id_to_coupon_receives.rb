class AddAccountIdToCouponReceives < ActiveRecord::Migration[5.1]
  def self.up
    change_table :coupon_receives do |t|
      t.integer :account_id
    end
  end

  def self.down
    change_table :coupon_receives do |t|
      t.remove :account_id
    end
  end
end
