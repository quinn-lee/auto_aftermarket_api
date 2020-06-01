class TAttribute < ActiveRecord::Base
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
end
