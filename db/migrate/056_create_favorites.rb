class CreateFavorites < ActiveRecord::Migration[5.1]
  def self.up
    create_table :favorites do |t|
      t.integer :merchant_id
      t.integer :customer_id
      t.integer :t_sku_id
      t.decimal :price, :precision => 10, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :favorites
  end
end
