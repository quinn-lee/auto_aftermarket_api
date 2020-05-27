class CreateGoods < ActiveRecord::Migration[5.1]
  def self.up
    create_table :goods do |t|
      t.string :name
      t.string :description
      t.json :pics
      t.string :comment
      t.integer :category_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :goods
  end
end
