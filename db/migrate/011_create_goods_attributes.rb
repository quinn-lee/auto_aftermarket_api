class CreateGoodsAttributes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :goods_attributes do |t|
      t.integer :goods_id
      t.integer :attribute_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :goods_attributes
  end
end
