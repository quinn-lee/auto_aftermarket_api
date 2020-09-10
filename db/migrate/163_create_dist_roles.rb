class CreateDistRoles < ActiveRecord::Migration[5.1]
  def self.up
    create_table :dist_roles do |t|
      t.string :name
      t.decimal :dist_percent, :precision => 12, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :dist_roles
  end
end
