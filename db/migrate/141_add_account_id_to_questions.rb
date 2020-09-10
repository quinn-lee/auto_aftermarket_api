class AddAccountIdToQuestions < ActiveRecord::Migration[5.1]
  def self.up
    change_table :questions do |t|
      t.integer :account_id
    end
  end

  def self.down
    change_table :questions do |t|
      t.remove :account_id
    end
  end
end
