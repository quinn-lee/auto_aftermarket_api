class AddMerchantIdToAgentChanges < ActiveRecord::Migration[5.1]
  def self.up
    change_table :agent_changes do |t|
      t.integer :merchant_id
    end
  end

  def self.down
    change_table :agent_changes do |t|
      t.remove :merchant_id
    end
  end
end
