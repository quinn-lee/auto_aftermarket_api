# encoding: utf-8
# 营销活动

class Activity < ActiveRecord::Base
  belongs_to :merchant,   :class_name => 'Merchant'

  def to_api
    {
      title: title,
      content: content,
      image: image
    }
  end

end
