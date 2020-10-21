module Jobspikr
  class Deprecator
    def self.build(version: "1.0")
      ActiveSupport::Deprecation.new(version, "jobspikr-ruby")
    end
  end
end
