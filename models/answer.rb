# encoding: utf-8
# 问题答案
require 'carrierwave/orm/activerecord'
class Answer < ActiveRecord::Base
  belongs_to :question,   :class_name => 'Question'
  belongs_to :account,   :class_name => 'Account'
  has_many :answer_likes, :class_name => 'AnswerLike', :dependent => :destroy

  mount_uploaders :images, FileUploader
  mount_uploader :audio, AudioUploader

  def to_api(current_customer=nil)
    al = answer_likes.where(account_id: current_customer.id).first if current_customer
    {
      id: id,
      content: content,
      images: images.try{|i| i.map(&:url)},
      audio: audio.present? ? audio.url : nil,
      customer: account.present? ? account.wechat_info : nil,
      account: staff_id.present? ? "Y" : "N",
      answer_likes: answer_likes.count,
      answer_liked: al.present? ? "Y" : "N",
      created_at: created_at.strftime("%F %T")
    }
  end

  def staff
    Account.find(staff_id) if staff_id.present?
  end

  def nickname
    if staff.present?
      "商家#{staff.name}回复"
    else
      account.present? ? (account.wechat_info.present? ? (account.wechat_info['nickName'] || '匿名') : '匿名') : '匿名'
    end
  end

end
