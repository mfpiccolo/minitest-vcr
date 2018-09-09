require 'coveralls'
Coveralls.wear!

begin
  require "bundler"
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install bundler` to install Bundler."
  exit e.status_code
end

begin
  Bundler.setup(:default, :development, :test)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems."
  exit e.status_code
end

require "minitest/autorun"
require "minispec-metadata"
require "active_support/testing/metadata"
require "vcr"
require "minitest-vcr"
require "webmock"
require "mocha/setup"
require "faraday"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end
