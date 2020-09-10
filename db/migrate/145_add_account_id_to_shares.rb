class AddAccountIdToShares < ActiveRecord::Migration[5.1]
  def self.up
    change_table :shares do |t|
      t.integer :account_id
    end
  end

  def self.down
    change_table :shares do |t|
      t.remove :account_id
    end
  end
end
