class CreateSkuViews < ActiveRecord::Migration[5.1]
  def self.up
    create_table :sku_views do |t|
      t.integer :customer_id
      t.datetime :visit_time
      t.string :t_sku_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :sku_views
  end
end
