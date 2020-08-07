class CreateAgentChanges < ActiveRecord::Migration[5.1]
  def self.up
    create_table :agent_changes do |t|
      t.string :content
      t.integer :status
      t.integer :customer_id
      t.integer :account_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :agent_changes
  end
end
