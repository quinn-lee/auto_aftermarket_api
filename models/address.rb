# encoding: utf-8
# 客户收件地址

class Address < ActiveRecord::Base

  def to_api
    {
      id: id,
      province: province,
      city: city,
      district: district,
      address: address,
      name: name,
      mobile: mobile
    }
  end
end
