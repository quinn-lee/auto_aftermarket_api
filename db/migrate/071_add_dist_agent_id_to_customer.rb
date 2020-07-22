class AddDistAgentIdToCustomer < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.integer :dist_agent_id
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :dist_agent_id
    end
  end
end
