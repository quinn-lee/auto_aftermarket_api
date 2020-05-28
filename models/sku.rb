require 'carrierwave/orm/activerecord'
class Sku < ActiveRecord::Base
  belongs_to :goods, :class_name => 'Goods'

  mount_uploaders :pics, FileUploader
end
