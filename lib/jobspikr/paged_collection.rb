class Jobspikr::PagedCollection < Jobspikr::Collection
  attr_accessor :cursor, :next_cursor

  def initialize(query = {}, &block)
    @cursor = query[:cursor]

    super(query, &block)
  end

  def more?
    @next_cursor.present?
  end

  def next_page?
    more?
  end

  def next_page
    @cursor = next_cursor
    fetch
    self
  end

protected
  def fetch
    @resources, @next_cursor = @fetch_proc.call(@query, @cursor)
  end
end
