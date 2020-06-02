class RemoveFieldsFromWxpayInfos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :wxpay_infos do |t|
      t.remove :amount
    end
  end

  def self.down
    change_table :wxpay_infos do |t|
      t.integer :amount
    end
  end
end
