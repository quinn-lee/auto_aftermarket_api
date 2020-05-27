class CreateShops < ActiveRecord::Migration[5.1]
  def self.up
    create_table :shops do |t|
      t.integer :merchant_id
      t.string :name
      t.string :address
      t.string :contact_name
      t.string :contact_phone
      t.jsonb :workstation
      t.jsonb :business_time
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :shops
  end
end
