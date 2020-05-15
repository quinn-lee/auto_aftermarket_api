class CreateCarBrands < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_brands do |t|
      t.string :brand
      t.jsonb :models
      t.string :abc
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_brands
  end
end
