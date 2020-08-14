class AddOldAgentIdToAgentChanges < ActiveRecord::Migration[5.1]
  def self.up
    change_table :agent_changes do |t|
      t.integer :old_agent_id
    end
  end

  def self.down
    change_table :agent_changes do |t|
      t.remove :old_agent_id
    end
  end
end
