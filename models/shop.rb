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
end
