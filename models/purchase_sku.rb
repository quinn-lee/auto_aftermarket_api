class PurchaseSku < ActiveRecord::Base
  belongs_to :purchase,   :class_name => 'Purchase'
  belongs_to :t_sku, :class_name => 'TSku'

  after_create do
    update_sku_stock_num!
  end

  def update_sku_stock_num!
    t_sku.update!(stock_num: (t_sku.stock_num || 0) + (quantity || 0), available_num: (t_sku.available_num || 0) + (quantity || 0))
  end
end
