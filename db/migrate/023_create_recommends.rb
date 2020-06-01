class CreateRecommends < ActiveRecord::Migration[5.1]
  def self.up
    create_table :recommends do |t|
      t.string :name
      t.string :rtype
      t.integer :t_category_id
      t.integer :t_spu_id
      t.integer :t_sku_id
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
