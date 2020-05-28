class RemoveFieldsFromGoods < ActiveRecord::Migration[5.1]
  def self.up
    change_table :goods do |t|
      t.remove :comment
    end
  end

  def self.down
    change_table :goods do |t|
      t.string :comment
    end
  end
end
