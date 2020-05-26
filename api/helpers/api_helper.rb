# encoding: utf-8
module AutoAftermarketApi
  class Api
    module ApiHelper
      TIMEOUT_NORMAL = Padrino.env == :production ? 30:120
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

      # 调用外部url统一使用该方法
      def method_url_call(method,url_path,params={},is_spec=nil,timeout=TIMEOUT_NORMAL,token=nil)
        if method.blank? || url_path.blank?
          raise "wrong url and method"
        end

        if url_path[0,4]=="http"
          url=url_path
        else
          url="http://"+url_path
        end

        begin
          uri = URI.parse(url)

          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl =  uri.scheme == 'https' if url_path[0,5]=="https"

          if is_spec=="JSON"
            if(method=="get")
              request = Net::HTTP::Get.new(uri.request_uri,initheader = {'Content-Type' =>'application/json'})
            else
              request = Net::HTTP::Post.new(uri.request_uri,initheader = {'Content-Type' =>'application/json'})
            end
          else
            if(method=="get")
              request = Net::HTTP::Get.new(uri.request_uri)
            else
              request = Net::HTTP::Post.new(uri.request_uri)
            end
          end

          if is_spec=="JSON"
            request.body=params.to_json
          elsif is_spec=="JSON_CONTENT_TYPE"
            request.content_type = "application/json"
            request.body=params.to_json
          elsif is_spec=="STR_BODY"
            request.body = params
          else
            request.set_form_data(params)
          end

          logger.info("CALL: url[#{url}] and timeout[#{timeout}]")
          unless Padrino.env == :production
            logger.info("body ===> [#{request.body}]")
            request.each do |r_key,r_value|
              logger.info("#{r_key} ===> #{r_value}")
            end
          end
          request.add_field "authorization",token if token

          response=nil
          Timeout::timeout(timeout){
            response=http.request(request)
          }
          [response.code,response.body,response]
        rescue => e
          logger.info("method_url_call failure: #{e.message}")
          logger.info(e.backtrace.inspect) unless Padrino.env == :production
          if e.class == Timeout::Error
            e_body = "Time out, please try again"
          else
            e_body = "Unknown anomaly"
          end
          ['400', e_body, nil]
        end
      end # end method_url_call


      def generate_token len = 40
        seed = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a
        token = ""
        len.times { |t| token << seed.sample.to_s }
        token
      end

    end

    helpers ApiHelper
  end
end
