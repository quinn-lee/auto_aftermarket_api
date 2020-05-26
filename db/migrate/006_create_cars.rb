class CreateCars < ActiveRecord::Migration[5.1]
  def self.up
    create_table :cars do |t|
      t.integer :customer_id
      t.integer :car_model_id
      t.string :car_model_name
      t.datetime :license_date
      t.string :color
      t.integer :mileage
      t.jsonb :mileage_his
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :cars
  end
end
