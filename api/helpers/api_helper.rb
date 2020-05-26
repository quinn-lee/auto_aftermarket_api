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

    end

    helpers ApiHelper
  end
end
