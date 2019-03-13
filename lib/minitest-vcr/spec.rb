require "vcr"
require "minispec-metadata"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        if metadata[:vcr]
          options = metadata[:vcr].is_a?(Hash) ? metadata[:vcr] : {}
          cassette_name = options.delete(:cassette_name)
          VCR.insert_cassette cassette_name || StringHelpers.vcr_path(example), options
        end
      end

      run_after = lambda do |example|
        ::VCR.eject_cassette if metadata[:vcr]
      end

      ::MiniTest::Spec.before :each, &run_before
      ::MiniTest::Spec.after :each, &run_after
    end

  end # Spec

  module StringHelpers

    def self.vcr_path(example)
      description_stack(example).push(extract_example_description(example)).join("/")
    end

    protected

    def self.description_stack(example)
      frame = example.class
      stack = []

      while frame != Minitest::Spec do
        stack.unshift frame.desc.to_s
        frame = frame.superclass
      end

      return stack
    end

    # Minitest::Spec takes the example description and writes
    # a test_NNNN_ in front of it, and doesn't actually keep
    # the original anywhere. Okay, we'll take it out.
    def self.extract_example_description(example)
      if (example.name =~ /\Atest_\d{4}_(.*)\z/)
        return $1
      else
        return example.name
      end
    end

  end
end # MinitestVcr

if defined? ActiveSupport::TestCase
  class ActiveSupport::TestCase
    def before_setup
      super
      if self.class.name.match("::vcr::")
        base_path = self.class.name.split("::")
          .map {|p| p.underscore.gsub(" ", "_") unless p == "vcr" }.join("/")

        file_name = name.gsub(/^test_.\d+_/, " ").strip.gsub(" ", "_")
        VCR.insert_cassette(base_path + "/" + file_name)
      end
    end

    def after_teardown
      if self.class.name.match("::vcr::")
        ::VCR.eject_cassette
      end
      super
    end
  end
end
