class CreateGroups < ActiveRecord::Migration[5.1]
  def self.up
    create_table :groups do |t|
      t.string :title
      t.string :detail
      t.integer :merchant_id
      t.integer :created_by
      t.decimal :group_price, :precision => 10, :scale => 2
      t.integer :status
      t.integer :t_sku_id
      t.jsonb :sku_info
      t.datetime :begin_time
      t.datetime :end_time
      t.integer :min_num
      t.integer :max_num
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :groups
  end
end
