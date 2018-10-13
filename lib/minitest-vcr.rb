require "minitest-vcr/version"
require "minitest-vcr/spec"
require "minitest-vcr/active_support/test_case"

module MinitestVcr
  def self.included(base)
    base.send(:include, MinitestVcr::Spec)
    super
  end
end
