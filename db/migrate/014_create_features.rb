class CreateFeatures < ActiveRecord::Migration[5.1]
  def self.up
    create_table :features do |t|
      t.integer :category_id
      t.string :name
      t.string :description
      t.string :feature_type
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :features
  end
end
