# encoding: utf-8
# 标签
class Label < ActiveRecord::Base

  validates :name, :ltype, presence: true

  LTYPE = {
    1 => '优选标签'
  }.stringify_keys

  def to_api
    {
      id: id,
      name: name
    }
  end

end
