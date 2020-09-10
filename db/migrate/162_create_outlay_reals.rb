class CreateOutlayReals < ActiveRecord::Migration[5.1]
  def self.up
    create_table :outlay_reals do |t|
      t.integer :outlay_id
      t.decimal :paid_amount, :precision => 12, :scale => 2
      t.date :paid_date
      t.string :remark
      t.integer :account_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :outlay_reals
  end
end
