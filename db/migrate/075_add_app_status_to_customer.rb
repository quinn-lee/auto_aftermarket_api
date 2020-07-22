class AddAppStatusToCustomer < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.integer :app_status
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :app_status
    end
  end
end
