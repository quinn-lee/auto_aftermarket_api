class CreateCarYears < ActiveRecord::Migration[5.1]
  def self.up
    create_table :car_years do |t|
      t.string :brand
      t.string :car_model
      t.string :manufacturer
      t.string :year
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :car_years
  end
end
