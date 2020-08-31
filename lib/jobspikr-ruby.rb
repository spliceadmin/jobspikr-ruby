require 'active_support'
require 'active_support/core_ext'
require 'httparty'
require 'jobspikr/exceptions'
require 'jobspikr/resource'
require 'jobspikr/collection'
require 'jobspikr/paged_collection'
require 'jobspikr/properties'
require 'jobspikr/company'
require 'jobspikr/company_properties'
require 'jobspikr/config'
require 'jobspikr/connection'
require 'jobspikr/contact'
require 'jobspikr/contact_properties'
require 'jobspikr/contact_list'
require 'jobspikr/form'
require 'jobspikr/blog'
require 'jobspikr/topic'
require 'jobspikr/deal'
require 'jobspikr/deal_pipeline'
require 'jobspikr/deal_properties'
require 'jobspikr/deprecator'
require 'jobspikr/owner'
require 'jobspikr/engagement'
require 'jobspikr/subscription'
require 'jobspikr/oauth'

module Jobspikr
  def self.configure(config={})
    Jobspikr::Config.configure(config)
  end

  require 'jobspikr/railtie' if defined?(Rails)
end

# Alias the module for those looking to use the stylized name JobsPikr
JobsPikr = Jobspikr