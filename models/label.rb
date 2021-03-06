# encoding: utf-8
# 标签
class Label < ActiveRecord::Base

  validates :name, :ltype, presence: true

  mount_uploader :image, FileUploader

  LTYPE = {
    1 => '优选标签',
    2 => '优选',
    3 => '团购',
    4 => '秒杀',
  }.stringify_keys

  def to_api
    {
      id: id,
      name: name,
      image: image.present? ? image.url : nil
    }
  end

end
