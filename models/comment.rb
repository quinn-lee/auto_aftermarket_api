# encoding: utf-8
# 评论
class Comment < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Account'
  belongs_to :order,   :class_name => 'Order'
  belongs_to :t_sku,   :class_name => 'TSku'
  belongs_to :t_spu,   :class_name => 'TSpu'

  mount_uploaders :images, FileUploader

  def to_api
    {
      id: id,
      content: content,
      rating: rating,
      images: images.try{|i| i.map(&:url)},
      order: order.order_no,
      sku: t_sku.to_api_order,
      created_at: created_at.strftime("%F %T")
    }
  end

end
