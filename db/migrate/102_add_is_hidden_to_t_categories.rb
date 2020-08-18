class AddIsHiddenToTCategories < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_categories do |t|
      t.boolean :is_hidden, default: false
    end
  end

  def self.down
    change_table :t_categories do |t|
      t.remove :is_hidden
    end
  end
end
