class CreateTSkus < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_skus do |t|
      t.integer :t_spu_id
      t.integer :merchant_id
      t.string :sku_code
      t.string :title
      t.json :images
      t.decimal :price, :precision => 10, :scale => 2
      t.jsonb :sale_attrs
      t.jsonb :attrs
      t.boolean :saleable
      t.boolean :is_valid
      t.integer :stock_num
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_skus
  end
end
