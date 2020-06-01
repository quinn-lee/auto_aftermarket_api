class TBrand < ActiveRecord::Base
  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy
end
