require 'jobspikr-ruby'
require 'rails'
module Jobspikr
  class Railtie < Rails::Railtie
    rake_tasks do
      spec = Gem::Specification.find_by_name('jobspikr-ruby')
    end
  end
end
