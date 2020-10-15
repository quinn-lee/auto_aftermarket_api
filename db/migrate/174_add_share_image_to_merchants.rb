class AddShareImageToMerchants < ActiveRecord::Migration[5.1]
  def self.up
    change_table :merchants do |t|
      t.jsonb :share_image
    end
  end

  def self.down
    change_table :merchants do |t|
      t.remove :share_image
    end
  end
end
