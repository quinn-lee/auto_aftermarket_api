class CreateInventories < ActiveRecord::Migration[5.1]
  def self.up
    create_table :inventories do |t|
      t.integer :merchant_id
      t.string :sku_code
      t.integer :num
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :inventories
  end
end
