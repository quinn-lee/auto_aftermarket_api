class AddDistPercentToTSpu < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_spus do |t|
      t.decimal :dist_percent, :precision => 10, :scale => 2
    end
  end

  def self.down
    change_table :t_spus do |t|
      t.remove :dist_percent, :precision => 10, :scale => 2
    end
  end
end
