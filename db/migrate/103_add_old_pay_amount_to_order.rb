class AddOldPayAmountToOrder < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.decimal :old_pay_amount, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :old_pay_amount
    end
  end
end
