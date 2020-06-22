class TCategory < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy
  has_many :t_attributes, :class_name => 'TAttribute', :dependent => :destroy

  def to_api
    {
      id: id,
      parent_id: parent_id,
      parent_name: parent_id.present? ? TCategory.find(parent_id).name : "",
      name: name,
      brands: TBrand.where(id: TCategoryBrand.where(t_category_id: id).map(&:t_brand_id)).map(&:to_api),
      attributes: t_attributes.map(&:to_api)
    }
  end

  def to_api_simple
    {
      id: id,
      parent_id: parent_id,
      name: name
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

  def brands
    TBrand.where(id: TCategoryBrand.where(t_category_id: id).map(&:t_brand_id))
  end
end
