class AddFieldsToRecommends < ActiveRecord::Migration[5.1]
  def self.up
    change_table :recommends do |t|
      t.string :rtype
    end
  end

  def self.down
    change_table :recommends do |t|
      t.remove :rtype
    end
  end
end
