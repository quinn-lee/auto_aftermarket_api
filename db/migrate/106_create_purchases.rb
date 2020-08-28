class CreatePurchases < ActiveRecord::Migration[5.1]
  def self.up
    create_table :purchases do |t|
      t.string :purchase_no
      t.string :summary
      t.jsonb :code_info
      t.integer :merchant_id
      t.integer :account_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :purchases
  end
end
