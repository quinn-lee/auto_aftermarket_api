class CreateComments < ActiveRecord::Migration[5.1]
  def self.up
    create_table :comments do |t|
      t.integer :order_id
      t.integer :t_sku_id
      t.json :images
      t.integer :rating
      t.string :content
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :comments
  end
end
