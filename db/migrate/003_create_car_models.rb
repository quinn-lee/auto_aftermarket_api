class CreateCarModels < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_models do |t|
      t.integer :car_year_id
      t.string :model_name
      t.string :model_version
      t.string :model_type
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_models
  end
end
