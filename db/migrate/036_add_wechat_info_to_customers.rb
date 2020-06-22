class AddWechatInfoToCustomers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.jsonb :wechat_info
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :wechat_info
    end
  end
end
