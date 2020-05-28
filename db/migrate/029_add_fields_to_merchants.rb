class AddFieldsToMerchants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :merchants do |t|
      t.string :mch_key
    end
  end

  def self.down
    change_table :merchants do |t|
      t.remove :mch_key
    end
  end
end
