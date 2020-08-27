class AddRejectReasonToOrder < ActiveRecord::Migration[5.1]
  def self.up
    change_table :orders do |t|
      t.string :reject_reason
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :reject_reason
    end
  end
end
