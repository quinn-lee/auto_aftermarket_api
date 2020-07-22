class CreateActivities < ActiveRecord::Migration[5.1]
  def self.up
    create_table :activities do |t|
      t.json :image
      t.string :title
      t.string :content
      t.integer :merchant_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :activities
  end
end
