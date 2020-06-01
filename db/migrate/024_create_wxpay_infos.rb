class CreateWxpayInfos < ActiveRecord::Migration[5.1]
  def self.up
    create_table :wxpay_infos do |t|
      t.string :prepay_id
      t.integer :customer_id
      t.string :order_no
      t.integer :amount
      t.datetime :expired_time
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :wxpay_infos
  end
end
