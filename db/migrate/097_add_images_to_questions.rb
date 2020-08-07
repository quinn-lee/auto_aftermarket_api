class AddImagesToQuestions < ActiveRecord::Migration[5.1]
  def self.up
    change_table :questions do |t|
      t.json :images
    end
  end

  def self.down
    change_table :questions do |t|
      t.remove :images
    end
  end
end
