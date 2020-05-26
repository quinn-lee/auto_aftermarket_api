class CreateCustomers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :customers do |t|
      t.string :name
      t.string :sex
      t.string :mobile
      t.datetime :birth
      t.jsonb :address
      t.string :openid
      t.string :unionid
      t.string :token
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :customers
  end
end
