# encoding: utf-8
# 问题表
class Question < ActiveRecord::Base
  belongs_to :topic,   :class_name => 'Topic'
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :customer,   :class_name => 'Account'
  has_many :answers, :class_name => 'Answer', :dependent => :destroy

  validates :content, :merchant_id, :topic_id, presence: true

  mount_uploaders :images, FileUploader

  def to_api(current_customer=nil)
    {
      id: id,
      content: content,
      images: images.try{|i| i.map(&:url)},
      topic: topic.to_api,
      customer: customer.present? ? customer.wechat_info : nil,
      customer_answers_num: answers.where(account_id: nil).count,
      customer_answers: answers.where(account_id: nil).order("created_at desc").map{|answer| answer.to_api(current_customer)},
      account_answers: answers.where.not(account_id: nil).order("created_at desc").map{|answer| answer.to_api(current_customer)},
      created_at: created_at.strftime("%F %T"),
      updated_at: updated_at.strftime("%F %T"),
      sku_id: t_sku_id
    }
  end

  def nickname
    customer.present? ? (customer.wechat_info.present? ? (customer.wechat_info['nickName'] || '匿名') : '匿名') : '匿名'
  end

end
