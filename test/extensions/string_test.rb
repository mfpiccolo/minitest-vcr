require "helper"

MinitestVcr::Spec.configure!

describe String do

  describe "prep" do
    it "returns an array of descriptions" do
      "a describe with metadata::with a nested example group::uses a cassette for any examples"
        .prep.must_equal([
          'a describe with metadata',
          'with a nested example group',
          'uses a cassette for any examples'
        ])
    end
  end

end
