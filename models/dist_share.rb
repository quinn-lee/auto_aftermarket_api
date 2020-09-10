# encoding: utf-8
# 分销分享表

class DistShare < ActiveRecord::Base
  belongs_to :account,   :class_name => 'Account'


  # 根据分享链，找出最近邻的分销员，注意返回的account可能不是分销员
  def self.agent(dist_share_id)
    ds = DistShare.find(dist_share_id)
    while ds.parent_id.present? # 存在上级分享时，继续循环
      break if (([1, 2].include?ds.account.role_id) && (ds.account.app_status == 1)) #当前已经是分销员了，退出循环
      ds = DistShare.find(ds.parent_id)
    end
    ds.account
  end

end
