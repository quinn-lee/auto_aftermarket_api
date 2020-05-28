class RemoveFieldsFromRecommends < ActiveRecord::Migration[5.1]
  def self.up
    change_table :recommends do |t|
      t.remove :type
    end
  end

  def self.down
    change_table :recommends do |t|
      t.string :type
    end
  end
end
