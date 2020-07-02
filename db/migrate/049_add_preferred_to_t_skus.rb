class AddPreferredToTSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_skus do |t|
      t.integer :preferred, default: 0
    end
  end

  def self.down
    change_table :t_skus do |t|
      t.remove :preferred
    end
  end
end
