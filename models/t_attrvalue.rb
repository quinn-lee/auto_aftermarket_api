class TAttrvalue < ActiveRecord::Base
  belongs_to :t_attribute,   :class_name => 'TAttribute'
end
