class AddStatusToSubOrder < ActiveRecord::Migration[5.1]
  def self.up
    change_table :sub_orders do |t|
      t.string :status
    end
  end

  def self.down
    change_table :sub_orders do |t|
      t.remove :status
    end
  end
end
