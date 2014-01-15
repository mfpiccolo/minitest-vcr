require "vcr"
require "minispec-metadata"
require "extensions/string"

module MinitestVcr
  module Spec

    def self.configure!
      run_before = lambda do |example|
        if metadata[:vcr]

          example.class.name.scan(/^(.*?)::[abc]/) do |class_names|
            class_name = class_names.first

            if class_name.nil?
              @path = example.class.name.prep
            else
              @path = example.class.name.gsub(class_name, "").prep.unshift(class_name)
            end
          end

          VCR.insert_cassette @path.push(spec_name).join("/") unless @path.nil?
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
