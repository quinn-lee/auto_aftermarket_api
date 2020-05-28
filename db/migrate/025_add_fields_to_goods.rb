class AddFieldsToGoods < ActiveRecord::Migration[5.1]
  def self.up
    change_table :goods do |t|
      t.json :desc_pics
    end
  end

  def self.down
    change_table :goods do |t|
      t.remove :desc_pics
    end
  end
end
