class AddInfoServiceIdToAccounts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :accounts do |t|
      t.integer :info_service_id
    end
  end

  def self.down
    change_table :accounts do |t|
      t.remove :info_service_id
    end
  end
end
