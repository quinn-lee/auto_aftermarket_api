class AgentChange < ActiveRecord::Base
  belongs_to :account,   :class_name => 'Account'

  # 更换专属客服通知
  def change_subscribe
    code,body=WebFunctions.method_url_call("get","https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=#{Settings.wechat.appId}&secret=#{Settings.wechat.appSecret}",{},"JSON")
    if code!="200"
      logger.info("call api weixin expection , [#{code}]")
      raise "call api weixin timeout,please try again"
    else
      res=JSON.parse body
      old_customer = Account.find(old_agent_id)
      now_customer = Account.find(account.info_service_id)
      if res["errcode"].present?
        raise res['errmsg']
      else
        access_token = res['access_token']
        data = {
          "thing1"=>{value: (old_customer.wechat_info||{})['nickName'][0..19]},
          "thing2"=>{value: (now_customer.wechat_info||{})['nickName'][0..19]},
          "thing3"=>{value: "您的专属客服已变更为#{(now_customer.wechat_info||{})['nickName']}"[0..19]}
        }
        param = {
          touser: account.openid,
          template_id: "8eIYZ-5AYvtVoNIYPqpsMSX_qJXl4s2TNOvciP_YPjs",
          data: data,
          miniprogram_state: "trial"
        }
        code,body=WebFunctions.method_url_call("post","https://api.weixin.qq.com/cgi-bin/message/subscribe/send?access_token=#{access_token}",param,"JSON")
        if code!="200"
          logger.info("call api subscribe expection , [#{code}]")
          raise "call api subscribe timeout,please try again"
        else
          logger.info("call api subscribe success")
        end
      end
    end
  end

end
