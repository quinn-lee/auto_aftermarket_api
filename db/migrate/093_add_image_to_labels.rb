class AddImageToLabels < ActiveRecord::Migration[5.1]
  def self.up
    change_table :labels do |t|
      t.json :image
    end
  end

  def self.down
    change_table :labels do |t|
      t.remove :image
    end
  end
end
