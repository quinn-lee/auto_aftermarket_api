class CreateDiscounts < ActiveRecord::Migration[5.1]
  def self.up
    create_table :discounts do |t|
      t.string :order_no
      t.string :discount_reason
      t.decimal :discount_amount, :precision => 8, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :discounts
  end
end
