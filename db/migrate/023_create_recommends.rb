class CreateRecommends < ActiveRecord::Migration[5.1]
  def self.up
    create_table :recommends do |t|
      t.string :name
      t.string :type
      t.integer :category_id
      t.integer :goods_id
      t.integer :sku_id
      t.integer :car_year_id
      t.integer :car_model_id
      t.integer :quantity
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :recommends
  end
end
