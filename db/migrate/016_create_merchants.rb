class CreateMerchants < ActiveRecord::Migration[5.1]
  def self.up
    create_table :merchants do |t|
      t.string :name
      t.string :password
      t.string :email
      t.string :mobile
      t.string :appid
      t.string :appsecret
      t.string :mch_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :merchants
  end
end
