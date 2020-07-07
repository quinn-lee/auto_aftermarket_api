class CreateAnswerLikes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :answer_likes do |t|
      t.integer :answer_id
      t.integer :customer_id
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :answer_likes
  end
end
