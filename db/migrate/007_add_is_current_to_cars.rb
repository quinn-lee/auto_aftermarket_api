class AddIsCurrentToCars < ActiveRecord::Migration[5.1]
  def self.up
    change_table :cars do |t|
      t.boolean :is_current
    end
  end

  def self.down
    change_table :cars do |t|
      t.remove :is_current
    end
  end
end
