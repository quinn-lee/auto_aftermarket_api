class CreateWithdraws < ActiveRecord::Migration[5.1]
  def self.up
    create_table :withdraws do |t|
      t.integer :customer_id
      t.integer :merchant_id
      t.datetime :app_date
      t.decimal :amount, :precision => 10, :scale => 2
      t.integer :status
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :withdraws
  end
end
