class AddAmountToWxpayInfos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :wxpay_infos do |t|
      t.decimal :amount, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :wxpay_infos do |t|
      t.decimal :amount, :precision => 10, :scale => 2
    end
  end
end
