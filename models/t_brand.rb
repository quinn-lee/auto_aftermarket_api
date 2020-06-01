class TBrand < ActiveRecord::Base
  has_many :t_spus, :class_name => 'TSpu', :dependent => :destroy

  def to_api
    {
      id: id,
      name: name,
      detail: detail,
      image: image,
      letter: letter
    }
  end
end
