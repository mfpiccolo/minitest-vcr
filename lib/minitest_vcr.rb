require "minitest_vcr/version"
require "minitest_vcr/spec"

module MinitestVcr
  def self.included(base)
    base.send(:include, MinitestVcr::Spec)
    super
  end
end
