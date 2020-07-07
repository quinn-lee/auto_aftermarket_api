class CreateQuestions < ActiveRecord::Migration[5.1]
  def self.up
    create_table :questions do |t|
      t.string :content
      t.integer :merchant_id
      t.integer :customer_id
      t.integer :topic_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :questions
  end
end
