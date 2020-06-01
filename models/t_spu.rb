class TSpu < ActiveRecord::Base
  belongs_to :t_category,   :class_name => 'TCategory'
  belongs_to :t_brand,   :class_name => 'TBrand'
  belongs_to :merchant,   :class_name => 'Merchant'
  has_many :t_skus, :class_name => 'TSku', :dependent => :destroy


  def to_api
    {
      id: id,
      title: title,
      category: t_category.to_api,
      detail: detail,
      skus: t_skus.map(&:to_api_simple)
    }
  end

  def to_api_simple
    {
      id: id,
      title: title,
      category: t_category.to_api,
      detail: detail
    }
  end
end
