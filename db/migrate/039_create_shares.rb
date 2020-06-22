class CreateShares < ActiveRecord::Migration[5.1]
  def self.up
    create_table :shares do |t|
      t.integer :customer_id
      t.string :url
      t.jsonb :options
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :shares
  end
end
