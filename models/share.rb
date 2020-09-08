# encoding: utf-8
# 分享记录
class Share < ActiveRecord::Base
  belongs_to :account,   :class_name => 'Account'

end
