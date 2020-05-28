# encoding: utf-8
module AutoAftermarketApi
  class Api
    module ApiHelper
      def api_rescue
        begin
          block_given? ? yield : raise('no block given')
        rescue Exception => e
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

    end

    helpers ApiHelper
  end
end
