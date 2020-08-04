class CreateLabels < ActiveRecord::Migration[5.1]
  def self.up
    create_table :labels do |t|
      t.string :name
      t.integer :ltype
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :labels
  end
end
