class Category < ActiveRecord::Base
  has_many :goods, :class_name => 'Goods'

  def to_api
    {
      id: id,
      parent_id: parent_id,
      name: name
    }
  end

  def self.all_categories
    # 两级目录结构
    categories = []
    Category.where("parent_id is null").each do |category|
      cg = category.to_api
      cs = Category.where(parent_id: category.id)
      cg['sub'] = cs.map(&:to_api)
      categories << cg
    end
    categories
  end
end
