class AddServiceFeeToTSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_skus do |t|
      t.jsonb :service_fee
    end
  end

  def self.down
    change_table :t_skus do |t|
      t.remove :service_fee
    end
  end
end
