class CreateCategories < ActiveRecord::Migration[5.1]
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id
      t.string :cate_type
      t.boolean :is_hidden
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :categories
  end
end
