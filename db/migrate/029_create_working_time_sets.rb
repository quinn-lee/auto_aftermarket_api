class CreateWorkingTimeSets < ActiveRecord::Migration[5.1]
  def self.up
    create_table :working_time_sets do |t|
      t.integer :shop_id
      t.integer :t_category_id
      t.decimal :hours, :precision => 10, :scale => 2
      t.boolean :need_lift
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :working_time_sets
  end
end
