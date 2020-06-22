class AddHisLocationInfoToCustomers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.jsonb :his_location_info
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :his_location_info
    end
  end
end
