# frozen_string_literal: true

require 'vcr'
require 'active_support/testing/metadata'

module MinitestVcr
  module ActiveSupport
    module TestCase
      def before_setup
        super

        return unless metadata.key?(:vcr)

        base_path = self.class.name.split('::').map do |p|
          p.underscore.tr(' ', '_')
        end

        base_path = File.join(*base_path)

        file_name = name.gsub(/^test_.\d+_/, ' ').strip.tr(' ', '_')
        path      = File.join(base_path, file_name)

        options = metadata[:vcr].is_a?(Hash) ? metadata[:vcr] : {}

        ::VCR.insert_cassette(path, options)
      end

      def after_teardown
        ::VCR.eject_cassette if metadata.key?(:vcr)

        super
      end
    end
  end
end
