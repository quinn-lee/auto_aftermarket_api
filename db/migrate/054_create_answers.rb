class CreateAnswers < ActiveRecord::Migration[5.1]
  def self.up
    create_table :answers do |t|
      t.integer :question_id
      t.string :content
      t.json :images
      t.json :audio
      t.integer :customer_id
      t.integer :account_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :answers
  end
end
