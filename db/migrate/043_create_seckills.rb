class CreateSeckills < ActiveRecord::Migration[5.1]
  def self.up
    create_table :seckills do |t|
      t.string :title
      t.string :detail
      t.integer :merchant_id
      t.integer :created_by
      t.integer :t_sku_id
      t.jsonb :sku_info
      t.integer :num
      t.integer :status
      t.datetime :begin_time
      t.datetime :end_time
      t.decimal :seckill_price, :precision => 10, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :seckills
  end
end
