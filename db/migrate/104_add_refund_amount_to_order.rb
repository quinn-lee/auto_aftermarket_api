class AddRefundAmountToOrder < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.decimal :refund_amount, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :refund_amount
    end
  end
end
