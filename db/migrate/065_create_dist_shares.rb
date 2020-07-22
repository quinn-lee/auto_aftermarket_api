class CreateDistShares < ActiveRecord::Migration[5.1]
  def self.up
    create_table :dist_shares do |t|
      t.integer :customer_id
      t.integer :parent_id
      t.integer :activity_id
      t.integer :coupon_id
      t.integer :sku_id
      t.integer :merchant_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :dist_shares
  end
end
