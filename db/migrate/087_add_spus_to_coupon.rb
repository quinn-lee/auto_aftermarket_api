class AddSpusToCoupon < ActiveRecord::Migration[5.1]
  def self.up
    change_table :coupons do |t|
      t.jsonb :spus
    end
  end

  def self.down
    change_table :coupons do |t|
      t.remove :spus
    end
  end
end
