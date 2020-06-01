class CreateTAttributes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_attributes do |t|
      t.integer :t_category_id
      t.string :name
      t.boolean :numeric
      t.boolean :generic
      t.boolean :selling
      t.boolean :searching
      t.string :unit
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_attributes
  end
end
