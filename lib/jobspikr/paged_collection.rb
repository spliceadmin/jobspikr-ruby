class Jobspikr::PagedCollection < Hubspot::Collection
  attr_accessor :cursor, :limit

  def initialize(opts = {}, &block)
    @limit_param = opts.delete(:limit_param) || "limit"
    @limit = opts.delete(:limit) || 25
    @cursor = opts.delete(:cursor)

    super(opts, &block)
  end

  def more?
    @has_more
  end

  def next_cursor
    @next_cursor
  end

  def next_page?
    @has_more
  end

  def next_page
    @cursor = next_cursor
    fetch
    self
  end

protected
  def fetch
    @resources, @next_cursor, @has_more = @fetch_proc.call(@options, @cursor, @limit)
  end
end
