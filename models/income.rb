# encoding: utf-8
# 应收表
class Income < ActiveRecord::Base
  has_many :income_reals, :class_name => 'IncomeReal', :dependent => :destroy

end
