class CreateTAttrvalues < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_attrvalues do |t|
      t.integer :t_category_id
      t.integer :t_attribute_id
      t.string :value
      t.boolean :is_valid
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_attrvalues
  end
end
