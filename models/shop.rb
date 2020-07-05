# encoding: utf-8
# 商户门店记录，一个商户有一个或多个门店
class Shop < ActiveRecord::Base
  belongs_to :merchant,   :class_name => 'Merchant'

  def to_api
    {
      id: id,
      name: name,
      address: address,
      contact_name: contact_name,
      contact_phone: contact_phone,
      workstation: workstation,
      business_time: business_time
    }
  end

  def to_api_simple
    {
      id: id,
      name: name,
      address: address,
      contact_name: contact_name,
      contact_phone: contact_phone,
    }
  end
end
