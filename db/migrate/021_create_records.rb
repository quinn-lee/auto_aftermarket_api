class CreateRecords < ActiveRecord::Migration[5.1]
  def self.up
    create_table :records do |t|
      t.integer :car_id
      t.string :order_no
      t.datetime :record_date
      t.string :order_type
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :records
  end
end
