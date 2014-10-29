require "helper"

MinitestVcr::Spec.configure!

describe MinitestVcr::Spec, :vcr => {:tag => :some_tag, :match_requests_on => [:method, :uri, :body]} do
  before do
    conn = Faraday.new
    @response = conn.get "http://example.com"
  end

  it "top level example" do
    VCR.current_cassette.name.must_equal "MinitestVcr::Spec/top level example"
  end

  describe "nested describe" do
    it "example in nested describe" do
      VCR.current_cassette.name.must_equal "MinitestVcr::Spec/nested describe/example in nested describe"
    end
  end

end


describe "top level describe", :vcr do    
  describe "an inner describe" do
    it "a test inside inner describe" do
      conn = Faraday.new
      @response = conn.get "http://example.com"

      VCR.current_cassette.name.must_equal "top level describe/an inner describe/a test inside inner describe"
    end
  end

  it "makes a request succesfully" do
  end
end