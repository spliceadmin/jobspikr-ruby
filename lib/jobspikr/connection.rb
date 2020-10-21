module Jobspikr
  class Connection
    include HTTParty

    class << self
      def get_json(path, opts)
        url = generate_url(path, opts)
        response = get(url, format: :json, read_timeout: read_timeout(opts), open_timeout: open_timeout(opts))
        log_request_and_response url, response
        handle_response(response)
      end

      protected
        def read_timeout(opts = {})
          opts.delete(:read_timeout) || Jobspikr::Config.read_timeout
        end

        def open_timeout(opts = {})
          opts.delete(:open_timeout) || Jobspikr::Config.open_timeout
        end

        def handle_response(response)
          if response.success?
            response.parsed_response
          else
            raise(Jobspikr::RequestError.new(response))
          end
        end

        def log_request_and_response(uri, response, body=nil)
          Jobspikr::Config.logger.info(<<~MSG)
            Jobspikr: #{uri}.
            Body: #{body}.
            Response: #{response.code} #{response.body}
          MSG
        end

        def generate_url(path, params={}, options={})
          path = path.clone
          params = params.clone
          base_url = options[:base_url] || Jobspikr::Config.base_url

          params.each do |k,v|
            if path.match(":#{k}")
              path.gsub!(":#{k}", CGI.escape(v.to_s))
              params.delete(k)
            end
          end
          raise(Jobspikr::MissingInterpolation.new("Interpolation not resolved")) if path =~ /:/

          query = params.map do |k,v|
            v.is_a?(Array) ? v.map { |value| param_string(k,value) } : param_string(k,v)
          end.join("&")

          path += path.include?('?') ? '&' : "?" if query.present?
          base_url + path + query
        end

        # convert into milliseconds since epoch
        def converted_value(value)
          value.is_a?(Time) ? (value.to_i * 1000) : CGI.escape(value.to_s)
        end

        def param_string(key,value)
          case key
            when /range/
              raise "Value must be a range" unless value.is_a?(Range)
              "#{key}=#{converted_value(value.begin)}&#{key}=#{converted_value(value.end)}"
            when /^batch_(.*)$/
              key = $1.gsub(/(_.)/) { |w| w.last.upcase }
              "#{key}=#{converted_value(value)}"
            else
              "#{key}=#{converted_value(value)}"
          end
        end
    end
  end
end
