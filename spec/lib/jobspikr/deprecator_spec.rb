RSpec.describe Jobspikr::Deprecator do
  describe ".build" do
    it "returns an instance of ActiveSupport::Deprecation" do
      deprecator = Jobspikr::Deprecator.build

      expect(deprecator).to be_an_instance_of(ActiveSupport::Deprecation)
    end

    it "uses the correct gem name" do
      deprecator = Jobspikr::Deprecator.build

      expect(deprecator.gem_name).to eq("jobspikr-ruby")
    end
  end
end
