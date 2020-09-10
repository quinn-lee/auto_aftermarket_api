class AddStaffIdToAnswers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :answers do |t|
      t.integer :staff_id
    end
  end

  def self.down
    change_table :answers do |t|
      t.remove :staff_id
    end
  end
end
