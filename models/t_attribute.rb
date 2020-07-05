# encoding: utf-8
# 目录销售属性
class TAttribute < ActiveRecord::Base
  validates :name, presence: true
  belongs_to :t_category,   :class_name => 'TCategory'
  has_many :t_attrvalues, :class_name => 'TAttrvalue', :dependent => :destroy

  def to_api
    {
      name: name,
      numeric: numeric,
      generic: generic,
      selling: selling,
      searching: searching,
      unit: unit,
      values: t_attrvalues.where(is_valid: true).map(&:value)
    }
  end

  def selling_desc
    selling ? '销售属性' : '展示属性'
  end
  def searching_desc
    searching ? '是' : '否'
  end
end
