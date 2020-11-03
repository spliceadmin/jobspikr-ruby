class Jobspikr::JobSearch < Jobspikr::Resource
  PATH = "/v2/data"
  self.resource_field = "job_data"

  class << self

    def search(query)
      Jobspikr::PagedCollection.new(query) do |jobs, cursor|
        body = query.merge(cursor: cursor)
        response = JobsPikr::Connection.post_json(PATH, { body: body, cursor: cursor })
        jobs = response[resource_field].map { |result| from_result(result) }
        [jobs, response["next_cursor"]]
      end
    end
  end
end

