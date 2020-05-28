class Shop < ActiveRecord::Base

  def to_api
    {
      name: name,
      address: address,
      contact_name: contact_name,
      contact_phone: contact_phone,
      workstation: workstation,
      business_time: business_time
    }
  end

end
