require 'active_support'
require 'active_support/core_ext'
require 'httparty'
require 'jobspikr/exceptions'
require 'jobspikr/resource'
require 'jobspikr/collection'
require 'jobspikr/paged_collection'
require 'jobspikr/config'
require 'jobspikr/connection'
require 'jobspikr/job_search'

module Jobspikr
 def self.configure(config={})
   Jobspikr::Config.configure(config)
 end

 require 'jobspikr/railtie' if defined?(Rails)
end

# Alias the module for those looking to use the stylized name JobsPikr
JobsPikr = Jobspikr