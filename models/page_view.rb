# encoding: utf-8
# 客户浏览记录
class PageView < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Account'

  def to_api
    {
      id: id,
      url: url,
      visit_time: visit_time.try{|v| v.strftime("%F %T")}
    }
  end

end
