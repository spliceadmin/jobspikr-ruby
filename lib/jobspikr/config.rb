require 'logger'
require 'jobspikr/connection'

module Jobspikr
  class Config
    CONFIG_KEYS = [
      :base_url, :logger, :client_id, :client_auth_key, :read_timeout, :open_timeout
    ]
    DEFAULT_LOGGER = Logger.new(nil)
    DEFAULT_BASE_URL = "https://api.jobspikr.com".freeze

    class << self
      attr_accessor *CONFIG_KEYS

      def configure(config)
        config.stringify_keys!
        @base_url = config["base_url"] || DEFAULT_BASE_URL
        @logger = config["logger"] || DEFAULT_LOGGER
        @client_id = config["client_id"] if config["client_id"].present?
        @client_auth_key= config["client_auth_key"] if config["client_auth_key"].present?
        @read_timeout = config["read_timeout"] || config["timeout"]
        @open_timeout = config["open_timeout"] || config["timeout"]
        self
      end

      def reset!
        @base_url = DEFAULT_BASE_URL
        @logger = DEFAULT_LOGGER
        @access_token = nil
        Jobspikr::Connection.headers({})
      end

      def ensure!(*params)
        params.each do |p|
          raise Jobspikr::ConfigurationError.new("'#{p}' not configured") unless instance_variable_get "@#{p}"
        end
      end

      private
    end

    reset!
  end
end
