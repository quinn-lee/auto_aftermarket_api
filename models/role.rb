# encoding: utf-8
# 角色表

class Role < ActiveRecord::Base
  has_many :accounts, :class_name => 'Account', :dependent => :destroy
end
