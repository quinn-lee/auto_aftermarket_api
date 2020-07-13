# encoding: utf-8
# 商品浏览记录
class SkuView < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Customer'

  def to_api
    {
      id: id,
      sku_id: t_sku_id,
      visit_time: visit_time.try{|v| v.strftime("%F %T")}
    }
  end

end
