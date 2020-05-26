class CreateCarModelDetails < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_model_details do |t|
      t.integer :car_model_id
      t.string :energy_type
      t.string :engine_capacity
      t.string :intake_type
      t.string :engine_max_power
      t.string :engine_max_torque
      t.string :battery_type
      t.string :battery_energy
      t.string :motor_max_power
      t.string :motor_max_torque
      t.string :gearbox
      t.integer :length
      t.integer :width
      t.integer :height
      t.integer :weight
      t.string :front_tire_size
      t.string :rear_tire_size
      t.string :wheel_hub_spec
      t.jsonb :engine_oil_label
      t.decimal :max_engine_oil_volume, :precision => 8, :scale => 2
      t.jsonb :brake_fluid_label
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_model_details
  end
end
