class AddDistShareIdToOrder < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.integer :dist_share_id
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :dist_share_id
    end
  end
end
