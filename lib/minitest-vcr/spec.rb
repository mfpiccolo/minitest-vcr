require "vcr"
require "minispec-metadata"
require "extensions/string"
require "database_cleaner"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        DatabaseCleaner.start rescue DatabaseCleaner::NoORMDetected
        VCR.insert_cassette example.class.name.vcr_path(example, spec_name) if metadata[:vcr]
      end

      run_after = lambda do |example|
        ::VCR.eject_cassette if metadata[:vcr]
        DatabaseCleaner.clean rescue DatabaseCleaner::NoORMDetected
      end

      ::MiniTest::Spec.before :each, &run_before
      ::MiniTest::Spec.after :each, &run_after
    end

  end # Spec
end # MinitestVcr
