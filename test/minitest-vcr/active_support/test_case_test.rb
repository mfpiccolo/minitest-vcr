require "helper"

class ActiveSupport::TestCase
  include MinitestVcr::ActiveSupport::TestCase
end

class MinitestVcr::ActiveSupport::TestCaseTest < ActiveSupport::TestCase
  test 'create a cassette name with the proper path', :vcr do
    conn = Faraday.new
    @response = conn.get 'http://example.com'

    expected = File.join(self.class.name.underscore, name)
    actual   = VCR.current_cassette.name

    assert_equal expected, actual
  end
end
