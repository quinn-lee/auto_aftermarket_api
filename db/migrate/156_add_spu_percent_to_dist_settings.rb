class AddSpuPercentToDistSettings < ActiveRecord::Migration[5.1]
  def self.up
    change_table :dist_settings do |t|
      t.decimal :spu_percent, :precision => 10, :scale => 2
      t.decimal :info_service_percent, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :dist_settings do |t|
      t.remove :spu_percent
      t.remove :info_service_percent
    end
  end
end
