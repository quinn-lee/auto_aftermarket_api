class CreateSeckillBuyers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :seckill_buyers do |t|
      t.integer :customer_id
      t.integer :seckill_id
      t.integer :order_id
      t.integer :t_sku_id
      t.integer :status
      t.integer :seckill_price
      t.integer :seckill_amount
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :seckill_buyers
  end
end
