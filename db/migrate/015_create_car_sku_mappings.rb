class CreateCarSkuMappings < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_sku_mappings do |t|
      t.string :sku_code
      t.integer :car_year_id
      t.integer :car_model_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_sku_mappings
  end
end
