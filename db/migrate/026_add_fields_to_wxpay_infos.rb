class AddFieldsToWxpayInfos < ActiveRecord::Migration[5.1]
  def self.up
    change_table :wxpay_infos do |t|
      t.jsonb :pay_detail
    t.string :transaction_id
    t.datetime :pay_time
    t.string :status
    end
  end

  def self.down
    change_table :wxpay_infos do |t|
      t.remove :pay_detail
    t.remove :transaction_id
    t.remove :pay_time
    t.remove :status
    end
  end
end
