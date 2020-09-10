class CreateIncomes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :incomes do |t|
      t.string :client_name
      t.string :client_phone
      t.string :contract_no
      t.date :contract_date
      t.string :subject
      t.decimal :contract_amount, :precision => 12, :scale => 2
      t.decimal :paid_amount, :precision => 12, :scale => 2
      t.date :due_date
      t.string :remark
      t.integer :account_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :incomes
  end
end
