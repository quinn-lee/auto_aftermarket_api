require 'carrierwave/orm/activerecord'
class Goods < ActiveRecord::Base
  has_many :skus, :class_name => 'Sku'
  mount_uploaders :pics, FileUploader

end
