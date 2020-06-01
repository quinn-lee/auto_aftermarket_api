class CreateTCategories < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_categories do |t|
      t.string :name
      t.integer :parent_id
      t.boolean :if_parent
      t.integer :sort
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_categories
  end
end
