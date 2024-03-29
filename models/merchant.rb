# encoding: utf-8
# 商户表，用于记录商户的小程序相关配置信息
class Merchant < ActiveRecord::Base

  mount_uploader :share_image, FileUploader

  has_many :shops, :class_name => 'Shop', :dependent => :destroy
  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy
  has_many :t_skus, :class_name => 'TSku', :dependent => :destroy
  has_many :orders, :class_name => 'Order', :dependent => :destroy
  has_many :purchases, :class_name => 'Purchase', :dependent => :destroy
  has_many :accounts, :class_name => 'Account', :dependent => :destroy

  has_many :groups, :class_name => 'Group', :dependent => :destroy
  has_many :coupons, :class_name => 'Coupon', :dependent => :destroy
  has_many :seckills, :class_name => 'Seckill', :dependent => :destroy

  has_many :questions, :class_name => 'Question', :dependent => :destroy

  has_many :activities, :class_name => 'Activity', :dependent => :destroy

  def agents
    accounts.where(role_id: [1,2]).map{|customer| [(customer.wechat_info||{})['nickName'], customer.id]}
  end

  def all_workers
    accounts.where.not(role_id: [3]).map{|customer| [customer.name, customer.id]}
  end
end
