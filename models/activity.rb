# encoding: utf-8
# 营销活动

class Activity < ActiveRecord::Base
  validates :image, presence: true

  belongs_to :merchant,   :class_name => 'Merchant'
  mount_uploader :image, FileUploader

  def to_api
    {
      id: id,
      title: title,
      content: content,
      image: image.present? ? image.url : nil
    }
  end

end
