class AddLocationInfoToCustomers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.jsonb :location_info
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :location_info
    end
  end
end
