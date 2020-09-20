class CreateCashFlows < ActiveRecord::Migration[5.1]
  def self.up
    create_table :cash_flows do |t|
      t.integer :merchant_id
      t.integer :account_id
      t.integer :order_id
      t.integer :income_real_id
      t.integer :outlay_real_id
      t.string :subject
      t.date :transaction_date
      t.decimal :amount, :precision => 12, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :cash_flows
  end
end
