class CreateTBrands < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_brands do |t|
      t.string :name
      t.string :detail
      t.string :image
      t.string :letter
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_brands
  end
end
