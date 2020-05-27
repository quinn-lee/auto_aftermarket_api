class CreateSkus < ActiveRecord::Migration[5.1]
  def self.up
    create_table :skus do |t|
      t.integer :goods_id
      t.string :sku_name
      t.string :sku_code
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :stock_quantity
      t.decimal :weight, :precision => 8, :scale => 2
      t.json :pics
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :skus
  end
end
