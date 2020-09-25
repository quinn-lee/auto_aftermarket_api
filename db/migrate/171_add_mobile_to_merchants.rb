class AddMobileToMerchants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :merchants do |t|
      t.string :contact_mobile
    t.string :customer_wechat_no
    end
  end

  def self.down
    change_table :merchants do |t|
      t.remove :contact_mobile
    t.remove :customer_wechat_no
    end
  end
end
