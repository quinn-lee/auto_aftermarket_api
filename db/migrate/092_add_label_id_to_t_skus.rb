class AddLabelIdToTSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_skus do |t|
      t.integer :label_id
    end
  end

  def self.down
    change_table :t_skus do |t|
      t.remove :label_id
    end
  end
end
