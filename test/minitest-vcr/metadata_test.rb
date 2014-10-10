require 'helper'

MinitestVcr::Spec.configure!


describe "with tag metadata", :vcr => {:tag => :bd_finditem} do

  before do
    conn = Faraday.new
    @response = conn.get 'http://example.com'
  end

  it "uses appropraite cassette name" do

    assert ! VCR.current_cassette.nil?, "No current cassette"

    assert ! VCR.current_cassette.name.nil?, "No current cassette name"


    if VCR.current_cassette.name
      (VCR.current_cassette.name.split('/')).must_equal([
        'with tag metadata',
        'uses appropraite cassette name'
      ])
    end
  end

end
