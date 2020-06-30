class CreateCouponReceives < ActiveRecord::Migration[5.1]
  def self.up
    create_table :coupon_receives do |t|
      t.integer :customer_id
      t.integer :coupon_id
      t.decimal :coupon_money, :precision => 10, :scale => 2
      t.decimal :full_money, :precision => 10, :scale => 2
      t.integer :status
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :coupon_receives
  end
end
