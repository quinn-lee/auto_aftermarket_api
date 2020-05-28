class CreateComments < ActiveRecord::Migration[5.1]
  def self.up
    create_table :comments do |t|
      t.string :content
      t.integer :customer_id
      t.integer :goods_id
      t.json :pics
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :comments
  end
end
