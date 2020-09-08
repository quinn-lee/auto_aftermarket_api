class AddOpenidToAccounts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :accounts do |t|
      t.string "sex"
      t.string "mobile"
      t.datetime "birth"
      t.jsonb "address"
      t.string "openid"
      t.string "unionid"
      t.string "token"
      t.jsonb "wechat_info", default: {}
      t.jsonb "location_info", default: {}
      t.jsonb "his_location_info"
      t.json "wx_barcode"
      t.integer "dist_share_id"
      t.integer "dist_agent_id"
      t.integer "app_status"
      t.json "avatar"
    end
  end

  def self.down
    change_table :accounts do |t|
      t.string "sex"
      t.string "mobile"
      t.datetime "birth"
      t.jsonb "address"
      t.string "openid"
      t.string "unionid"
      t.string "token"
      t.jsonb "wechat_info", default: {}
      t.jsonb "location_info", default: {}
      t.jsonb "his_location_info"
      t.json "wx_barcode"
      t.integer "dist_share_id"
      t.integer "dist_agent_id"
      t.integer "app_status"
      t.json "avatar"
    end
  end
end
