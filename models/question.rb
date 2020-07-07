# encoding: utf-8
# 问题表
class Question < ActiveRecord::Base
  belongs_to :topic,   :class_name => 'Topic'
  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :customer,   :class_name => 'Customer'
  has_many :answers, :class_name => 'Answer', :dependent => :destroy

  validates :content, :merchant_id, :topic_id, presence: true

  def to_api
    account_answer = answers.where.not(account_id: nil).first
    {
      id: id,
      content: content,
      topic: topic.to_api,
      customer: customer.present? ? customer.wechat_info : nil,
      customer_answers_num: answers.where(account_id: nil).count,
      customer_answers: answers.where(account_id: nil).order("created_at desc").map(&:to_api),
      account_answer: account_answer.present? ? account_answer.to_api : nil,
      created_at: created_at.strftime("%F %T")
    }
  end

end
