# encoding: utf-8
# 团购表
class Group < ActiveRecord::Base
  validates :title, :detail, :merchant_id, :group_price, :t_sku_id, :begin_time, :end_time, :min_num, presence: true

  belongs_to :merchant,   :class_name => 'Merchant'
  belongs_to :t_sku,   :class_name => 'TSku'

  has_many :group_buyers, :class_name => 'GroupBuyer', :dependent => :destroy

  STATUS = {
    1 => '上架',
    0 => '下架',
    2 => '成团',
    3 => '未成团'
  }.stringify_keys

  def to_api
    {
      id: id,
      title: title,
      detail: detail,
      group_price: group_price,
      status: STATUS[status.to_s],
      begin_time: begin_time.try{|bt| bt.strftime("%F %T")},
      end_time: end_time.try{|et| et.strftime("%F %T")},
      min_num: min_num,
      max_num: max_num,
      purchased_num: group_buyers.purchased.count,
      sku: t_sku.to_api_simple
    }
  end
end
