# encoding: utf-8
#微信支付专用类

class Wxpay
  attr_accessor :appid, :mch_id, :nonce_str, :device_info, :sign, :body, :detail, \
   :attach, :out_trade_no, :fee_type, :total_fee, :spbill_create_ip, :time_start, :time_expire,
   :goods_tag, :notify_url, :trade_type, :product_id, :limit_pay, :openid,\
   :appId, :timeStamp, :nonceStr, :package, :signType, :paySign,\
   :transaction_id, :sign_type, :return_code, :return_msg, :result_code, :is_subscribe,\
   :bank_type, :settlement_total_fee, :cash_fee, :cash_fee_type, :coupon_fee, :coupon_count,\
   :bill_date, :bill_type, :time_end, :coupon_fee_0, :coupon_id_0, :info

  #支付：统一下单
  def self.pre_pay(merchant, order_no, openid, total_fee, ip_address)
    begin
      ret_info={
        "status"=>"",
        "info"=>{}
      }
      logger.info("pre_pay order_no [#{order_no}] start: #{Time.now}")
      url="https://api.mch.weixin.qq.com/pay/unifiedorder"
      pay=Wxpay.new
      pay.appid=merchant.appid
      pay.body="JSAPI"
      pay.mch_id=merchant.mch_id
      pay.nonce_str=Wxpay.gen_rand_str(20)
      pay.notify_url="http://172.105.198.104:4000/v1.0/orders/notify"
      pay.openid= openid
      pay.out_trade_no=order_no
      pay.spbill_create_ip=ip_address  #!!!
      pay.total_fee=total_fee     #1
      pay.trade_type="JSAPI"
      pay.sign=pay.gen_sign(merchant)
      xbuilder = Builder::XmlMarkup.new(:target => ret_xml="")
      xbuilder.xml{
        xbuilder.appid pay.appid
        xbuilder.body pay.body
        xbuilder.mch_id pay.mch_id
        xbuilder.nonce_str pay.nonce_str
        xbuilder.notify_url pay.notify_url
        xbuilder.openid pay.openid
        xbuilder.out_trade_no pay.out_trade_no
        xbuilder.spbill_create_ip pay.spbill_create_ip
        xbuilder.total_fee pay.total_fee
        xbuilder.trade_type pay.trade_type
        xbuilder.sign pay.sign
      }

      code,rsp_body,response=WebFunctions.method_url_call("post",url,ret_xml,"STR_BODY")
      if code!="200"
        raise "pre_pay call failure: [#{code}],[#{rsp_body}]"
      end
      logger.info("#{rsp_body}")
      doc = Nokogiri::Slop rsp_body
      if doc.xml.return_code.content =="SUCCESS"&&doc.xml.return_msg.content =="OK"
        ret_info["status"]="succ"
        ret_info["info"]["appid"]=doc.xml.appid.content
        ret_info["info"]["mch_id"]=doc.xml.mch_id.content
        ret_info["info"]["trade_type"]=doc.xml.trade_type.content
        ret_info["info"]["prepay_id"]=doc.xml.prepay_id.content
      else
        ret_info["status"]="fail"
        ret_info["info"]["err_msg"]=doc.xml.return_msg.content
      end

    rescue => e
      logger.info("pre_pay error: #{e.message}")
      ret_info["status"]="fail"
      ret_info["info"]["err_msg"]=e.message
    end
    logger.info("pre_pay tx_num [#{order_no}] end: #{Time.now}")
    logger.info("ret_info:#{ret_info}")
    ret_info
  end

  #支付：查询订单
  def self.order_query(merchant, transaction_id, tx_num)
    begin
      ret_info={
        "status"=>"",
        "info"=>{}
      }
      logger.info("order_query order_num [#{transaction_id||tx_num}] start: #{Time.now}")
      url="https://api.mch.weixin.qq.com/pay/orderquery"
      pay=Wxpay.new
      pay.appid=merchant.appid
      pay.mch_id=merchant.mch_id
      pay.nonce_str=Wxpay.gen_rand_str(20)
      if transaction_id.present?
        pay.transaction_id=transaction_id
      else
        pay.out_trade_no=tx_num
      end
      # pay.sign_type="MD5"
      pay.sign=pay.gen_sign(merchant)
      xbuilder = Builder::XmlMarkup.new(:target => ret_xml="")
      if transaction_id.present?
      xbuilder.xml{
        xbuilder.appid pay.appid
        xbuilder.mch_id pay.mch_id
        xbuilder.nonce_str pay.nonce_str
        xbuilder.transaction_id pay.transaction_id
        xbuilder.sign pay.sign
      }
      else
      xbuilder.xml{
        xbuilder.appid pay.appid
        xbuilder.mch_id pay.mch_id
        xbuilder.nonce_str pay.nonce_str
        xbuilder.out_trade_no pay.out_trade_no
        xbuilder.sign pay.sign
      }
      end
      code,rsp_body,response=WebFunctions.method_url_call("post",url,ret_xml,"STR_BODY")
      if code!="200"
        raise "order_query call failure: [#{code}],[#{rsp_body}]"
      end
      logger.info("rsp_body: #{rsp_body}")
      doc = Nokogiri::Slop rsp_body
      if doc.xml.return_code.content =="SUCCESS"&&doc.xml.return_msg.content =="OK"
        ret_info["status"]="succ"
        ret_info["info"]["appid"]=doc.xml.appid.content
        ret_info["info"]["mch_id"]=doc.xml.mch_id.content
        ret_info["info"]["trade_state"]=doc.xml.trade_state.content
        ret_info["info"]["detail"]={}
        if ret_info["info"]["trade_state"]=="SUCCESS"
          ret_info["info"]["detail"]["openid"]=doc.xml.openid.content
          ret_info["info"]["detail"]["bank_type"]=doc.xml.bank_type.content #付款银行
          ret_info["info"]["detail"]["total_fee"]=doc.xml.total_fee.content #标价金额
          #ret_info["info"]["detail"]["settlement_total_fee"]=doc.xml.settlement_total_fee.content #应结订单金额
          ret_info["info"]["detail"]["fee_type"]=doc.xml.fee_type.content #标价币种
          ret_info["info"]["detail"]["cash_fee"]=doc.xml.cash_fee.content #现金支付金额
          #ret_info["info"]["detail"]["cash_fee_type"]=doc.xml.cash_fee_type.content #现金支付币种
          #ret_info["info"]["detail"]["coupon_count"]=doc.xml.coupon_count.content #代金券使用数量
          ret_info["info"]["detail"]["transaction_id"]=doc.xml.transaction_id.content #微信支付订单号
          ret_info["info"]["detail"]["out_trade_no"]=doc.xml.out_trade_no.content #商户订单号
          ret_info["info"]["detail"]["time_end"]=doc.xml.time_end.content #支付完成时间
          #ret_info["info"]["detail"]["trade_state_desc"]=doc.xml.trade_state_desc.content #交易状态描述
        end
      else
        ret_info["status"]="fail"
        ret_info["info"]["err_msg"]=doc.xml.return_msg.content
      end
    rescue => e
      logger.info("order_query error: #{e.message}")
      ret_info["status"]="fail"
      ret_info["info"]["err_msg"]=e.message
    end
    logger.info("order_query order_num [#{transaction_id||tx_num}] end: #{Time.now}")
    ret_info
  end

  #生成微信支付签名
  def gen_sign(merchant)
    #1.参数按ASCII码从小到大排序
    record_hash = {}
    instance_variables.each do |key|
      if instance_variable_get(key).present?
        record_hash[key.to_s.delete("@")] =instance_variable_get(key)
      end
    end
    sorted_hash=Hash[record_hash.sort]
    #2.拼接生成stringA : key1=value1&key2=value2
    stringA=sorted_hash.to_query
    logger.info("[stringA]: #{stringA}")
    #3.在stringA最后拼接上key得到stringSignTemp字符串，
    #并对stringSignTemp进行MD5运算，
    #再将得到的字符串所有字符转换为大写
    if stringA.match("&notify_url")!=nil
      stringSignTemp=Wxpay.url_decode(stringA+"&key="+merchant.mch_key)
    else
      stringSignTemp=stringA+"&key="+merchant.mch_key
    end
    logger.info("[stringSignTemp]: #{stringSignTemp}")
    sign=Digest::MD5.hexdigest(stringSignTemp).upcase
    logger.info("[sign]: #{sign}")
    return sign
  end

  #下载微信对帐单
  #bill_date: 下载对账单的日期，格式：20140603
  #bill_type: ALL，返回当日所有订单信息，默认值
    #SUCCESS，返回当日成功支付的订单
    #REFUND，返回当日退款订单
    #RECHARGE_REFUND，返回当日充值退款订单
  #Wxpay.download_bill("20180814","ALL")
  def self.download_bill(merchant, bill_date,bill_type)
    uri=""
    logger.info("download_bill start: #{Time.now}")
    url="https://api.mch.weixin.qq.com/pay/downloadbill"
    pay=Wxpay.new
    pay.appid=merchant.appid
    pay.mch_id=merchant.mch_id
    pay.nonce_str=Wxpay.gen_rand_str(20)
    pay.sign_type="MD5"
    pay.bill_date=bill_date
    pay.bill_type=bill_type
    pay.sign=pay.gen_sign(merchant)
    xbuilder = Builder::XmlMarkup.new(:target => ret_xml="")
      xbuilder.xml{
        xbuilder.appid pay.appid
        xbuilder.mch_id pay.mch_id
        xbuilder.nonce_str pay.nonce_str
        xbuilder.sign_type pay.sign_type
        xbuilder.sign pay.sign
        xbuilder.bill_date pay.bill_date
        xbuilder.bill_type pay.bill_type
      }
      code,rsp_body,response=WebFunctions.method_url_call("post",url,ret_xml,"STR_BODY")
      if code!="200"
        raise "download_bill call failure: [#{code}],[#{rsp_body}]"
      end
      logger.info("#{rsp_body}")
  end


  def self.url_encode(str)
    return URI.escape(str, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))
  end
  def self.url_decode(str)
  return str.gsub!(/%[a-fA-F0-9]{2}/) { |x| x = x[1..2].hex.chr }
end

  def self.to_query_string(hash)
    if hash.instance_of? String
      URI.encode hash
    else
      uri = Addressable::URI.new
      uri.query_values = hash
      uri.query
    end
  end
  #小写字母（26个）和数字（10个）组成
  def self.gen_random_str(len)
    rand(36 ** len).to_s(36)
  end
  # 字母（52个）和数字（10个）组成
  def self.gen_rand_str(len)
    rand_indexes = (0...len).collect{|i| rand(62)}
    [*(0..9),*('a'..'z'),*('A'..'Z')].values_at(*rand_indexes).join
  end

end
