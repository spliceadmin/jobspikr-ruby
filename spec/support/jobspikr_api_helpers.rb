module JobspikrApiHelpers
  def jobspikr_api_url(path)
    URI.join(Jobspikr::Config.base_url, path)
  end

  def assert_jobspikr_api_request(method, path, options = {})
    assert_requested(method, /#{jobspikr_api_url(path)}/, options)
  end
end

RSpec.configure do |c|
  c.include JobspikrApiHelpers
end
