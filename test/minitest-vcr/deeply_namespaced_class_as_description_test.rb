require "helper"

module Some
  module Crazy
    module Nested
      class RandomClass
      end
    end
  end
end

MinitestVcr::Spec.configure!

describe Some::Crazy::Nested::RandomClass, :vcr do
  before do
    conn = Faraday.new
    @response = conn.get "http://example.com"
  end

  it "top level example" do
    VCR.current_cassette.name.must_equal "Some::Crazy::Nested::RandomClass/top level example"
  end

  describe "nested describe" do
    it "example in nested describe" do
      VCR.current_cassette.name.must_equal "Some::Crazy::Nested::RandomClass/nested describe/example in nested describe"
    end
  end

end