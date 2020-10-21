require 'jobspikr-ruby'
require 'rails'
module Jobspikr
  class Railtie < Rails::Railtie
    rake_tasks do
      spec = Gem::Specification.find_by_name('jobspikr-ruby')
      load "#{spec.gem_dir}/lib/tasks/jobspikr.rake"
    end
  end
end
