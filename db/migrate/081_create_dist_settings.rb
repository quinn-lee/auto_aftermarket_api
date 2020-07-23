class CreateDistSettings < ActiveRecord::Migration[5.1]
  def self.up
    create_table :dist_settings do |t|
      t.integer :merchant_id
      t.boolean :dist_switch
      t.decimal :amount_limit, :precision => 10, :scale => 2
      t.integer :number_limit
      t.decimal :sales_percent, :precision => 10, :scale => 2
      t.decimal :dist_percent, :precision => 10, :scale => 2
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :dist_settings
  end
end
