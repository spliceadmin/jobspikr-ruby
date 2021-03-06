module Jobspikr
  class Properties

    PROPERTY_SPECS = {
      field_names:       %w(name groupName description fieldType formField type displayOrder label options showCurrencySymbol),
      valid_field_types: %w(textarea select text date file number radio checkbox booleancheckbox),
      valid_types:       %w(string number bool date datetime enumeration),
      options:           %w(description value label hidden displayOrder)
    }
    DEFAULT_PROPERTY = 'email'

    class << self
      # TODO: properties can be set as configuration
      # TODO: find the way how to set a list of Properties + merge same property key if present from opts
      def add_default_parameters(opts={})
        if opts.keys.map(&:to_s).include? 'property'
          opts
        else
          opts.merge(property: DEFAULT_PROPERTY)
        end
      end

      def same?(src, dst)
        src_params = valid_params(src)
        dst_params = valid_params(dst)
        src_params.eql?(dst_params)
        # hash_same?(src_params, dst_params)
      end

      def valid_params(params={})
        valid_property_params(params)
      end

      private

      def filter_results(results, key, include, exclude)
        key = key.to_s
        results.select { |result|
          (include.blank? || include.include?(result[key])) &&
            (exclude.blank? || !exclude.include?(result[key]))
        }
      end

      def valid_property_params(params)
        return {} if params.blank?
        result = params.slice(*PROPERTY_SPECS[:field_names])
        result.delete('fieldType') unless check_field_type(result['fieldType'])
        result.delete('type') unless check_type(result['type'])
        result['options'] = valid_option_params(result['options'])
        result
      end

      def check_field_type(val)
        return true if PROPERTY_SPECS[:valid_field_types].include?(val)
        puts "Invalid field type: #{val}"
        false
      end

      def check_type(val)
        return true if PROPERTY_SPECS[:valid_types].include?(val)
        puts "Invalid type: #{val}"
        false
      end

      def valid_option_params(options)
        return [] if options.blank?
        options.map { |o| o.slice(*PROPERTY_SPECS[:options]) }
      end
    end
  end
end
