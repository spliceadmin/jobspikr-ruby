RSpec.describe Jobspikr do
  describe ".configure" do
    it "delegates .configure to Jobspikr::Config.configure" do
      options = { hapikey: "demo" }
      allow(Jobspikr::Config).to receive(:configure).with(options)

      Jobspikr.configure(options)

      expect(Jobspikr::Config).to have_received(:configure).with(options)
    end
  end
end
