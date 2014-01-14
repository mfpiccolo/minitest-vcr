require "vcr"
require "minispec-metadata"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        if metadata[:vcr]
          example.class.name.scan(/^(.*?)::[abc]/) do |name|
            @class_name = name.first
          end

          if @class_name.nil?
            test_info = example.class.name.split("::").map {|e| e.sub(/[^\w]*$/, "")}.reject(&:empty?) - ["vcr"]
            @class_name = ""
          else
            test_info = example.class.name.gsub(@class_name, "").split("::").map {|e| e.sub(/[^\w]*$/, "")}.reject(&:empty?) - ["vcr"]
          end

          VCR.insert_cassette @class_name + "/" + test_info.join("/") + "/#{spec_name}"
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
