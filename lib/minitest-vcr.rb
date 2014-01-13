require "minitest-vcr/version"
require "minitest-vcr/spec"

module MinitestVcr
  def self.included(base)
    base.send(:include, MinitestVcr::Spec)
    super
  end
end
