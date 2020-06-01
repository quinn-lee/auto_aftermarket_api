class CreateLevels < ActiveRecord::Migration[5.1]
  def self.up
    create_table :levels do |t|
      t.string :level_name
      t.integer :discount
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :levels
  end
end
