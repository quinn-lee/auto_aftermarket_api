class Group < ActiveRecord::Base
  validates :title, :detail, :merchant_id, :group_price, :t_sku_id, :begin_time, :end_time, :min_num, presence: true

end
