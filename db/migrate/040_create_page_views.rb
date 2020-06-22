class CreatePageViews < ActiveRecord::Migration[5.1]
  def self.up
    create_table :page_views do |t|
      t.integer :customer_id
      t.datetime :visit_time
      t.string :url
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :page_views
  end
end
