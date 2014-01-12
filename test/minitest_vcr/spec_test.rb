require "helper"

MinitestVcr::Spec.configure!

describe MinitestVcr::Spec do

  describe 'an example group', vcr: true do
    describe 'with a nested example group' do
      before do
        conn = Faraday.new
        @response = conn.get 'http://example.com'
      end
      it 'uses a cassette for any examples' do
        (VCR.current_cassette.name.split('/')).must_equal([
          'MinitestVcr::Spec',
          'an example group',
          'with a nested example group',
          'uses a cassette for any examples'
        ])
      end
    end
  end

  describe "#configure!", vcr: true do

    before do
      ::MiniTest::Spec.expects(:before).with(:each).returns(:true)
      ::MiniTest::Spec.expects(:after).with(:each).returns(true)
    end

    it "recieves should call before and after with proper args and block" do
      MinitestVcr::Spec.configure!
    end
  end
end
