class AddWechatNoToWithdraw < ActiveRecord::Migration[5.1]
  def self.up
    change_table :withdraws do |t|
      t.string :wechat_no
    end
  end

  def self.down
    change_table :withdraws do |t|
      t.remove :wechat_no
    end
  end
end
