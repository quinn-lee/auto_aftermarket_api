class CreateCoupons < ActiveRecord::Migration[5.1]
  def self.up
    create_table :coupons do |t|
      t.string :title
      t.integer :ctype
      t.integer :merchant_id
      t.integer :created_by
      t.datetime :begin_time
      t.datetime :end_time
      t.decimal :money, :precision => 10, :scale => 2
      t.integer :status
      t.string :remarks
      t.decimal :full_money, :precision => 10, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :coupons
  end
end
