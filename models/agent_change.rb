class AgentChange < ActiveRecord::Base
  belongs_to :customer,   :class_name => 'Customer'

  # 更换分销员通知
  def change_subscribe
  end

end
