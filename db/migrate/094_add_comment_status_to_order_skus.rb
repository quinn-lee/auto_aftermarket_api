class AddCommentStatusToOrderSkus < ActiveRecord::Migration[5.1]
  def self.up
    change_table :order_skus do |t|
      t.integer :comment_status, default: 0
    end
  end

  def self.down
    change_table :order_skus do |t|
      t.remove :comment_status
    end
  end
end
