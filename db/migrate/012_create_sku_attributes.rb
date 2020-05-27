class CreateSkuAttributes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :sku_attributes do |t|
      t.string :sku_code
      t.integer :attribute_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sku_attributes
  end
end
