class AddDetailToTSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_skus do |t|
      t.jsonb :detail
    end
  end

  def self.down
    change_table :t_skus do |t|
      t.remove :detail
    end
  end
end
