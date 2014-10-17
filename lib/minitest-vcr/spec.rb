require "vcr"
require "minispec-metadata"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        if metadata[:vcr]
          options = metadata[:vcr].is_a?(Hash) ? metadata[:vcr] : {}
          VCR.insert_cassette StringHelpers.vcr_path(example, spec_name), options
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

    def self.vcr_path(example, spec_name)
      description_stack(example).push(spec_name).join("/")
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

  end
end # MinitestVcr
