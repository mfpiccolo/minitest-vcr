require "vcr"
require "minispec-metadata"
require "extensions/string"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        VCR.insert_cassette example.class.name.vcr_path(example, spec_name) if metadata[:vcr]
      end

      run_after = lambda do |example|
        ::VCR.eject_cassette if metadata[:vcr]
      end

      ::MiniTest::Spec.before :each, &run_before
      ::MiniTest::Spec.after :each, &run_after
    end

  end # Spec
end # MinitestVcr
