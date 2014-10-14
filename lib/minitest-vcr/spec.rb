require "vcr"
require "minispec-metadata"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        if metadata[:vcr]
          options = metadata[:vcr].is_a?(Hash) ? metadata[:vcr] : {}
          VCR.insert_cassette StringHelpers.vcr_path(example.class.name, example, spec_name), options
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

    def self.vcr_path(example_class_name, example, spec_name)
      # TODO Refactor!  To tired but this is wack.
      @path = nil

      @path = prep example.class.name

      @path.push(spec_name).join("/") unless @path.nil?
    end

    protected

    def self.prep string
      string.split("::").map {|e| e.sub(/[^\w]*$/, "")}.reject(&:empty?) - ["vcr"]
    end

  end
end # MinitestVcr
