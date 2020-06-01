class CreateTCategoryBrands < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_category_brands do |t|
      t.integer :t_category_id
      t.integer :t_brand_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_category_brands
  end
end
