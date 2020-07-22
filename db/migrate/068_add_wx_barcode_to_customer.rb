class AddWxBarcodeToCustomer < ActiveRecord::Migration[5.1]
  def self.up
    change_table :customers do |t|
      t.json :wx_barcode
    end
  end

  def self.down
    change_table :customers do |t|
      t.remove :wx_barcode
    end
  end
end
