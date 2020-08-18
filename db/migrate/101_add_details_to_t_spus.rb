class AddDetailsToTSpus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :t_spus do |t|
      t.json :details
    end
  end

  def self.down
    change_table :t_spus do |t|
      t.remove :details
    end
  end
end
