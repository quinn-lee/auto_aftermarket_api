class AddPreferredSloganToTSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_skus do |t|
      t.string :preferred_slogan
    end
  end

  def self.down
    change_table :t_skus do |t|
      t.remove :preferred_slogan
    end
  end
end
