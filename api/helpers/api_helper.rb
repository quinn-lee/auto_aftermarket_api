# encoding: utf-8
module AutoAftermarketApi
  class Api
    module ApiHelper
      def api_rescue
        begin
          block_given? ? yield : raise('no block given')
        rescue Exception => e
          logger.info "#{e.backtrace}"
          logger.info "FAIL #{request.path} - #{e.message}" unless Padrino.env == :production
          { status: 'fail', reason: [ e.message ] }.to_json
        end
      end

      def load_api_request_params
        request.body.rewind
        request_body_read = request.body.read
        logger.info "request body: #{request_body_read}"
        @request_params = JSON.parse(request_body_read) rescue params
      end

      # 用户认证
      # 请求header['token']="*"
      def authenticate
        logger.info env['HTTP_APPID']
        unless @customer = Customer.find_by(token: env['HTTP_TOKEN'])
          raise "token invalid"
        end
        unless @merchant = Merchant.find_by(appid: env['HTTP_APPID'])
          raise "appid invalid"
        end
      end

      def check_sign(doc, merchant)
    		logger.info("into check_sign")
    		origin_sign=doc.xml.sign.content
    		pay=Wxpay.new
    		pay.return_code=doc.xml.return_code.content
    		pay.appid=doc.xml.appid.content
    		pay.mch_id=doc.xml.mch_id.content
    		pay.nonce_str=doc.xml.nonce_str.content
    		pay.result_code=doc.xml.result_code.content
    		pay.openid=doc.xml.openid.content
    		pay.is_subscribe=doc.xml.is_subscribe.content
    		pay.trade_type=doc.xml.trade_type.content
    		pay.bank_type=doc.xml.bank_type.content
    		pay.total_fee=doc.xml.total_fee.content
    		pay.fee_type=doc.xml.fee_type.content
    		pay.cash_fee=doc.xml.cash_fee.content
    		if doc.xml.cash_fee.content!=doc.xml.total_fee.content
      		pay.coupon_fee=doc.xml.coupon_fee.content
      		pay.coupon_count=doc.xml.coupon_count.content
      		pay.coupon_fee_0=doc.xml.coupon_fee_0.content
      		pay.coupon_id_0=doc.xml.coupon_id_0.content
    		end
    		pay.transaction_id=doc.xml.transaction_id.content
    		pay.out_trade_no=doc.xml.out_trade_no.content
    		pay.time_end=doc.xml.time_end.content

    		calued_sign=pay.gen_sign(merchant)
    		if origin_sign==calued_sign
    			return true
    		else
    			return false
    		end
    	end

    	def pay_detail_transfer(doc)
    		hash=Hash.new
    		hash["openid"]=doc.xml.openid.content
    		hash["bank_type"]=doc.xml.bank_type.content
    		hash["total_fee"]=doc.xml.total_fee.content
    		#hash["settlement_total_fee"]=doc.xml.settlement_total_fee.content#应结订单金额=订单金额-非充值代金券金额，应结订单金额<=订单金额
    		hash["fee_type"]=doc.xml.fee_type.content
    		hash["cash_fee"]=doc.xml.cash_fee.content
    		#hash["cash_fee_type"]=doc.xml.cash_fee_type.content
    		#hash["coupon_count"]=doc.xml.coupon_count.content
    		hash["time_end"]=doc.xml.time_end.content
    		hash
    	end

    end

    helpers ApiHelper
  end
end
