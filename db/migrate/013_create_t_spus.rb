class CreateTSpus < ActiveRecord::Migration[5.1]
  def self.up
    create_table :t_spus do |t|
      t.integer :t_category_id
      t.integer :t_brand_id
      t.integer :merchant_id
      t.string :title
      t.string :detail
      t.boolean :saleable
      t.boolean :is_valid
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :t_spus
  end
end
