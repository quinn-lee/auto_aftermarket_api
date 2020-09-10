class CreateIncomeReals < ActiveRecord::Migration[5.1]
  def self.up
    create_table :income_reals do |t|
      t.integer :income_id
      t.decimal :paid_amount, :precision => 12, :scale => 2
      t.date :paid_date
      t.string :remark
      t.integer :account_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :income_reals
  end
end
