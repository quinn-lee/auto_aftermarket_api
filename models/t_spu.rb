# encoding: utf-8
# 产品SPU表
require 'carrierwave/orm/activerecord'
class TSpu < ActiveRecord::Base
  mount_uploaders :details, FileUploader

  validates :t_category_id, :title, presence: true

  belongs_to :t_category,   :class_name => 'TCategory'
  belongs_to :t_brand,   :class_name => 'TBrand'
  belongs_to :merchant,   :class_name => 'Merchant'
  has_many :t_skus, :class_name => 'TSku', :dependent => :destroy
  has_many :comments, :class_name => 'Comment', :dependent => :destroy


  def to_api
    spu_attrs = {}
    t_skus.each {|sku| sku.sale_attrs.each{|key, value| spu_attrs[key] = spu_attrs[key] || []; spu_attrs[key] << value; spu_attrs[key]=spu_attrs[key].uniq;}}
    {
      id: id,
      title: title,
      category: t_category.to_api_simple,
      detail: detail,
      brand: t_brand.try{|tb| tb.to_api},
      sale_attrs: spu_attrs,
      details: details.try{|i| i.map(&:url)},
      skus: t_skus.map(&:to_api_simple)
    }
  end

  def to_api_simple
    {
      id: id,
      title: title,
      category: t_category.to_api_simple,
      brand: t_brand.try{|tb| tb.to_api},
      detail: detail,
      details: details.try{|i| i.map(&:url)}
    }
  end

  def category_desc
    begin
      p_category = TCategory.find(t_category.parent_id)
      "#{p_category.name}/#{t_category.name}"
    rescue=>e
      ""
    end
  end

  def saleable_class
    saleable ? "pd-setting" : "ds-setting"
  end
  def saleable_desc
    saleable ? "正常" : "已下架"
  end
end
