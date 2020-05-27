class CreateAttributes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :attributes do |t|
      t.string :attr_name
      t.string :attr_value
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :attributes
  end
end
