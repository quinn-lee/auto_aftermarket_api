# encoding: utf-8
# 角色表

class Role < ActiveRecord::Base
  has_many :customers, :class_name => 'Customer', :dependent => :destroy

end
