# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minitest_vcr/version'

Gem::Specification.new do |spec|
  spec.name          = "minitest_vcr"
  spec.version       = MinitestVcr::VERSION
  spec.authors       = ["Mike Piccolo"]
  spec.email         = ["mpiccolo@newleaders.com"]
  spec.summary       = "Allows VCR to automatically make cassetes with proper file paths with MiniTest"
  spec.description   = "I like MiniTest.  I like VCR.  I like not having to manage cassetes."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'vcr',  '~> 2.8.0'
  spec.add_runtime_dependency 'minitest', '~> 4.7.5'
  spec.add_runtime_dependency 'minispec-metadata', '~> 1.0.0'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'vcr',  '~> 2.8.0'
  spec.add_development_dependency 'minitest', '~> 4.7.5'
  spec.add_development_dependency 'minispec-metadata', '~> 1.0.0'
  spec.add_development_dependency 'mocha',    '~> 0.14.0'
  spec.add_development_dependency 'faraday',    '~> 0.8.9'
  spec.add_development_dependency 'rubygems-tasks', '~> 0.2'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'webmock', '~> 1.16.0'
  spec.add_development_dependency 'pry',  ' ~> 0.9.12.2'
  spec.add_development_dependency 'pry-debugger', '~> 0.2.2'
end
