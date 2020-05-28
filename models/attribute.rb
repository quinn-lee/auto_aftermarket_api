class Attribute < ActiveRecord::Base

  def to_api
    {
      attr_name: attr_name,
      attr_value: attr_value
    }
  end
end
