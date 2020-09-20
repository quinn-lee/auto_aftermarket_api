class CreateReconciliationDetails < ActiveRecord::Migration[5.1]
  def self.up
    create_table :reconciliation_details do |t|
      t.integer :merchant_id
      t.integer :account_id
      t.integer :wxpay_info_id
      t.datetime :transaction_date
      t.string :mch_id
      t.string :order_no
      t.string :transaction_id
      t.string :transaction_type
      t.string :transaction_status
      t.decimal :amount, :precision => 12, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :reconciliation_details
  end
end
