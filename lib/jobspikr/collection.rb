class Jopspikr::Collection
  def initialize(opts = {}, &block)
    @options = opts
    @fetch_proc = block
    fetch
  end

  def refresh
    fetch
    self
  end

  def resources
    @resources
  end

protected
  def fetch
    @resources = @fetch_proc.call(@options)
  end

  def respond_to_missing?(name, include_private = false)
    @resources.respond_to?(name, include_private)
  end

  def method_missing(method, *args, &block)
    @resources.public_send(method, *args, &block)
  end
end