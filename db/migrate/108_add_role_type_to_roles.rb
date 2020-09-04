class AddRoleTypeToRoles < ActiveRecord::Migration[5.1]
  def self.up
    change_table :roles do |t|
      t.string :role_type
    end
  end

  def self.down
    change_table :roles do |t|
      t.remove :role_type
    end
  end
end
