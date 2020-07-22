class AddAvatarToCustomer < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.json :avatar
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :avatar
    end
  end
end
