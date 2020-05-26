class CreateCarModels < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_models do |t|
      t.integer :car_year_id
      t.string :car_model_name
      t.string :car_model_version
      t.string :car_model_type
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_models
  end
end
