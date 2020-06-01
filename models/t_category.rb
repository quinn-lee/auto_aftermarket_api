class TCategory < ActiveRecord::Base
  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy
  has_many :t_attributes, :class_name => 'TAttribute', :dependent => :destroy

  def to_api
    {
      id: id,
      parent_id: parent_id,
      name: name,
      attributes: t_attributes.map(&:to_api)
    }
  end

  def self.all_categories
    # 两级目录结构
    categories = []
    self.where("parent_id is null").each do |category|
      cg = category.to_api
      cs = self.where(parent_id: category.id)
      cg['sub'] = cs.map(&:to_api)
      categories << cg
    end
    categories
  end
end
