class Jobspikr::PagedCollection < Jobspikr::Collection
  attr_accessor :cursor, :next_cursor

  def initialize(query = {}, &block)
    @cursor = query[:cursor]

    super(query, &block)
  end

  def more?
    @response['next_cursor'].present? && @response['job_credit_remaining'] > 0
  end

  def next_page
    @cursor = @response['next_cursor']
    fetch
    self
  end

protected
  def fetch
    @resources, @response = @fetch_proc.call(@query, @cursor)
  end

  # Add custom methods for easily accessing response data
  def response_methods
    [:status, :total_count, :size, :job_credit_remaining]
  end

  def respond_to?(m, include_private = false)
    response_methods.include?(m.to_sym) || super
  end

  def method_missing(m, *args, &block)
    if response_methods.include?(m)
      @response[m.to_s]
    else
      raise ArgumentError.new("Method `#{m}` doesn't exist.")
    end
  end
end
