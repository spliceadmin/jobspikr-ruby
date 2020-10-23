class Jobspikr::JobSearch < Jobspikr::Resource
  PATH = "/v2/data"
  self.resource_field = "job_data"

  class << self

    def search(opts = {})
      Jobspikr::PagedCollection.new(opts) do |options, offset, limit|
        Jobspikr::Config.logger.info("opts: #{opts}")
        Jobspikr::Config.logger.info("options: #{options}")
        Jobspikr::Config.logger.info("offset: #{offeset}")
        Jobspikr::Config.logger.info("limit: #{limit}")
#        response = JobsPikr::Connection.get_json(
#          PATH,
#          options.merge("count" => limit, "vidOffset" => offset)
#        )
#
#        contacts = response["contacts"].map { |result| from_result(result) }
#        [contacts, response["vid-offset"], response["has-more"]]
      end
    end
  end
end

