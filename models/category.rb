class Category < ActiveRecord::Base
  has_many :goods, :class_name => 'Goods'

  def to_api
    {
      id: id,
      parent_id: parent_id,
      name: name
    }
  end
end
