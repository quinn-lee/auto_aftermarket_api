class AddTSpuIdToComments < ActiveRecord::Migration[5.1]
  def self.up
    change_table :comments do |t|
      t.integer :t_spu_id
    end
  end

  def self.down
    change_table :comments do |t|
      t.remove :t_spu_id
    end
  end
end
