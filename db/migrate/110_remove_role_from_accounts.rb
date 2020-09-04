class RemoveRoleFromAccounts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :accounts do |t|
      t.remove :role
    end
  end

  def self.down
    change_table :accounts do |t|
      t.string :role
    end
  end
end
