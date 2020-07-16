class AddDelivereTimeToOrder < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.datetime :delivere_time
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :delivere_time
    end
  end
end
