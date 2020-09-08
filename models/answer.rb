# encoding: utf-8
# 问题答案
require 'carrierwave/orm/activerecord'
class Answer < ActiveRecord::Base
  belongs_to :question,   :class_name => 'Question'
  belongs_to :customer,   :class_name => 'Account'
  belongs_to :account,   :class_name => 'Account'
  has_many :answer_likes, :class_name => 'AnswerLike', :dependent => :destroy

  mount_uploaders :images, FileUploader
  mount_uploader :audio, AudioUploader

  def to_api(current_customer=nil)
    al = answer_likes.where(customer_id: current_customer.id).first if current_customer
    {
      id: id,
      content: content,
      images: images.try{|i| i.map(&:url)},
      audio: audio.present? ? audio.url : nil,
      customer: customer.present? ? customer.wechat_info : nil,
      account: account.present? ? "Y" : "N",
      answer_likes: answer_likes.count,
      answer_liked: al.present? ? "Y" : "N",
      created_at: created_at.strftime("%F %T")
    }
  end

  def nickname
    if account.present?
      "商家回复#{account.email}"
    else
      customer.present? ? (customer.wechat_info.present? ? (customer.wechat_info['nickName'] || '匿名') : '匿名') : '匿名'
    end
  end

end
