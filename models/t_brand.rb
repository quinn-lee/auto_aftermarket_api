# encoding: utf-8
# 品牌表，与目录多对多，与spu，一对多
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
