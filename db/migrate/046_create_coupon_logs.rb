class CreateCouponLogs < ActiveRecord::Migration[5.1]
  def self.up
    create_table :coupon_logs do |t|
      t.integer :customer_id
      t.integer :coupon_receive_id
      t.integer :order_id
      t.decimal :order_original_amount, :precision => 10, :scale => 2
      t.decimal :coupon_amount, :precision => 10, :scale => 2
      t.decimal :order_final_amount, :precision => 10, :scale => 2
      t.integer :status
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :coupon_logs
  end
end
