require "vcr"
require "minispec-metadata"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        if metadata[:vcr]
          test_info = example.class.name.split("::::").map {|e| e.sub(/[^\w]*$/, "")}.reject(&:empty?)
          VCR.insert_cassette test_info.join("/") + "/#{spec_name}"
        end
      end

      run_after = lambda do |example|
        if metadata[:vcr]
          ::VCR.eject_cassette
        end
      end

      ::MiniTest::Spec.before :each, &run_before
      ::MiniTest::Spec.after :each, &run_after
    end

  end # Spec
end # MinitestVcr
