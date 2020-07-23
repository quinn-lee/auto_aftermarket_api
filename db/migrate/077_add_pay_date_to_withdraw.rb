class AddPayDateToWithdraw < ActiveRecord::Migration[5.1]
  def self.up
    change_table :withdraws do |t|
      t.datetime :pay_date
    end
  end

  def self.down
    change_table :withdraws do |t|
      t.remove :pay_date
    end
  end
end
