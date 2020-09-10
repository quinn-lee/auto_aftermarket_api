class AddDistShareIdToOrderSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :order_skus do |t|
      t.integer :dist_share_id
      t.integer :dist_agent_id
    end
  end

  def self.down
    change_table :order_skus do |t|
      t.remove :dist_share_id
      t.remove :dist_agent_id
    end
  end
end
