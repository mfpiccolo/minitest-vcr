# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest-vcr/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest-vcr"
  spec.version       = MinitestVcr::VERSION
  spec.authors       = ["Mike Piccolo"]
  spec.email         = ["mpiccolo@newleaders.com"]
  spec.summary       = "Allows VCR to automatically make cassetes with proper file paths with MiniTest"
  spec.description   = "I like MiniTest.  I like VCR.  I like not having to manage cassetes."
  spec.homepage      = ""
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "minispec-metadata", "~> 3.0"
  spec.add_dependency "minitest",          ">= 5"
  spec.add_dependency "vcr",               ">= 2.9"

  spec.add_development_dependency "bundler",  "~> 1.16"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake",     "~> 10.0"
end
