class AddAvailableNumToTSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_skus do |t|
      t.integer :available_num
    end
  end

  def self.down
    change_table :t_skus do |t|
      t.remove :available_num
    end
  end
end
