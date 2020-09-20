class AddMerchantIdToOutlayReals < ActiveRecord::Migration[5.1]
  def self.up
    change_table :outlay_reals do |t|
      t.integer :merchant_id
    end
  end

  def self.down
    change_table :outlay_reals do |t|
      t.remove :merchant_id
    end
  end
end
