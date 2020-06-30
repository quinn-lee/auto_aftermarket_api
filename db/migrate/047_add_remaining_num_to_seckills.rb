class AddRemainingNumToSeckills < ActiveRecord::Migration[5.1]
  def self.up
    change_table :seckills do |t|
      t.integer :remaining_num
    end
  end

  def self.down
    change_table :seckills do |t|
      t.remove :remaining_num
    end
  end
end
