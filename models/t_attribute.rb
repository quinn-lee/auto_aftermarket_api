class TAttribute < ActiveRecord::Base
  belongs_to :t_category,   :class_name => 'TCategory'
  has_many :t_attrvalues, :class_name => 'TAttrvalue', :dependent => :destroy
end
