class CreateAddresses < ActiveRecord::Migration[5.1]
  def self.up
    create_table :addresses do |t|
      t.integer :customer_id
      t.string :province
      t.string :city
      t.string :district
      t.string :address
      t.string :name
      t.string :mobile
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :addresses
  end
end
