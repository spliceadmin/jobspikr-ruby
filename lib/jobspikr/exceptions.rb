module Jobspikr
  class RequestError < StandardError
    attr_accessor :response

    def initialize(response, message=nil)
      message += "\n" if message
      msg = super("#{message}Response body: #{response.body}")
      msg.response = response
      return msg
    end
  end

  class ConfigurationError < StandardError; end
  class MissingInterpolation < StandardError; end
end
