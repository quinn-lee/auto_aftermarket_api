class Share < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Customer'

end
