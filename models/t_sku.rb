# encoding: utf-8
# 商品SKU表
require 'carrierwave/orm/activerecord'
class TSku < ActiveRecord::Base
  mount_uploaders :images, FileUploader
  mount_uploaders :detail, FileUploader

  validates :t_spu_id, :merchant_id, :title, :images, :price, :stock_num, :available_num, :sku_code, presence: true
  validates :sku_code, uniqueness: true

  belongs_to :t_spu,   :class_name => 'TSpu'
  belongs_to :merchant,   :class_name => 'Merchant'

  has_many :favorites, :class_name => 'Favorite', :dependent => :destroy
  has_many :sku_views, :class_name => 'SkuView', :dependent => :destroy
  has_many :comments, :class_name => 'Comment', :dependent => :destroy
  has_many :groups, :class_name => 'Group', :dependent => :destroy
  has_many :seckills, :class_name => 'Seckill', :dependent => :destroy

  PREFERRED = {
    1 => '优选',
    2 => '优选',
    0 => '普通'
  }.stringify_keys

  def to_api
    group = groups.where(status: 1).where("end_time > '#{Time.now.strftime('%F %T')}'").first
    seckill = seckills.where(status: 1).where("end_time > '#{Time.now.strftime('%F %T')}'").first
    {
      id: id,
      spu: t_spu.to_api_simple,
      title: title,
      sku_code: sku_code,
      price: price,
      service_fee: service_fee,
      stock_num: stock_num,
      available_num: available_num,
      preferred: PREFERRED[preferred.to_s],
      preferred_slogan: preferred_slogan,
      images: images.try{|i| i.map(&:url)},
      sale_attrs: sale_attrs,
      attrs: attrs,
      # detail: detail.try{|i| i.map(&:url)},
      group: group.present? ? {group_id: group.id, group_price: group.group_price, end_time: group.end_time.try{|et| et.strftime("%F %T")}} : nil,
      seckill: seckill.present? ? {seckill_id: seckill.id, seckill_price: seckill.seckill_price, end_time: seckill.end_time.try{|et| et.strftime("%F %T")}} : nil
    }
  end

  def to_api_simple
    group = groups.where(status: 1).where("end_time > '#{Time.now.strftime('%F %T')}'").first
    seckill = seckills.where(status: 1).where("end_time > '#{Time.now.strftime('%F %T')}'").first
    {
      id: id,
      title: title,
      sku_code: sku_code,
      price: price,
      service_fee: service_fee,
      stock_num: stock_num,
      available_num: available_num,
      preferred: PREFERRED[preferred],
      preferred_slogan: preferred_slogan,
      images: images.try{|i| i.map(&:url)},
      sale_attrs: sale_attrs,
      attrs: attrs,
      # detail: detail.try{|i| i.map(&:url)},
      group: group.present? ? {group_id: group.id, group_price: group.group_price, end_time: group.end_time.try{|et| et.strftime("%F %T")}} : nil,
      seckill: seckill.present? ? {seckill_id: seckill.id, seckill_price: seckill.seckill_price, end_time: seckill.end_time.try{|et| et.strftime("%F %T")}} : nil
    }
  end

  def to_api_order
    {
      id: id,
      title: title,
      sku_code: sku_code,
      images: images.try{|i| i.map(&:url)},
    }
  end

  def saleable_class
    saleable ? "pd-setting" : "ds-setting"
  end
  def saleable_desc
    saleable ? "正常" : "已下架"
  end

  def sale_attrs_desc
    sale_attrs.to_a.map{|sa| sa.join(':')}.join('，')
  end
end
