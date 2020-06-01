class CreateMerchants < ActiveRecord::Migration[5.1]
  def self.up
    create_table :merchants do |t|
      t.string :name
      t.string :appid
      t.string :appsecret
      t.string :mch_id
      t.string :mch_key
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :merchants
  end
end
