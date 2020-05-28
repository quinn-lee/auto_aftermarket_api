class AddFieldsToOrders < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.jsonb :delivery_info
    t.jsonb :contact_info
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :delivery_info
    t.remove :contact_info
    end
  end
end
