module Jobspikr
  class Resource

    class_attribute :id_field, instance_writer: false
    class_attribute :resource_field, instance_writer: false

    self.id_field = "uniq_id"

    class << self
      def from_result(result)
        resource = new(result[id_field])
        resource.send(:initialize_from, result.with_indifferent_access)
        resource
      end
    end

    def initialize(id)
      @id = id
    end

    def id
      @id
    end

    def id=(id)
      @id = id
    end

    def to_i
      @id
    end

  protected

    def initialize_from(response)
      @properties = response
      add_accessors(response.keys)
    end

    def add_accessors(keys)
      singleton_class.instance_eval do
        keys.each do |k|
          # Define a getter
          define_method(k) { @properties[k] }
        end
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      (@properties && @properties.key?(method_name)) || super
    end
  end
end