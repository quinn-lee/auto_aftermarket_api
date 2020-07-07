# encoding: utf-8
# 话题
class Topic < ActiveRecord::Base
  has_many :questions, :class_name => 'Question', :dependent => :destroy

  def to_api
    {
      id: id,
      title: title
    }
  end

end
