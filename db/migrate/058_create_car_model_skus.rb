class CreateCarModelSkus < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_model_skus do |t|
      t.integer :car_model_id
      t.integer :t_sku_id
      t.integer :t_category_id
      t.integer :merchant_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_model_skus
  end
end
