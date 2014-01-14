minitest-vcr
============

[![Build Status](https://travis-ci.org/mfpiccolo/minitest-vcr.png?branch=master)](https://travis-ci.org/mfpiccolo/minitest-vcr)

* [Homepage](http://mfpiccolo.github.io/minitest-vcr)
* [Issues](https://github.com/mfpiccolo/minitest-vcr/issues)
* [Documentation](http://rubydoc.info/gems/minitest-vcr/frames)
* [Email](mailto:mfpiccolo@gmail.com)

## Description

Allows VCR to automatically make cassetes with proper file paths using Minitest.

## Features

## Examples

Two main steps:

1.  Install and require the gem
2.  Add `MinitestVcr::Spec.configure!` before your tests load

The setup below will create a direcotry structre that looks like this:

    |-- app_name
    |  |-- test/
    |    |-- cassettes/
    |      |-- Example_Spec/
    |        |-- an_example_group/
    |          |-- with_a_nested_example_group/
    |          `-- uses_a_cassette_for_an_example_group.yml
    |    `-- example_test.rb
    |    `-- test_helper.rb

An example test_helper file: app_name/test/test_helper.rb

```ruby
require "minitest/autorun"
require "minispec-metadata"
require "vcr"
require "minitest-vcr"
require "webmock"
require "mocha/setup"
require "faraday"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
end

MinitestVcr::Spec.configure!
```

An example test file: app_name/test/example_test.rb

```ruby
require "test_helper"

describe Example::Spec do

  # Notice here symbols are treated as true values
  # You could also do vcr: true
  describe 'an example group', :vcr do
    describe 'with a nested example group' do
      before do
        conn = Faraday.new
        @response = conn.get 'http://example.com'
      end
      it 'uses a cassette for any examples' do
        @response.wont_equal nil
      end
    end
  end
end
```

## Requirements


## Installation

Add this line to your application's Gemfile:

```ruby
gem "minitest-vcr"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-vcr

## Donating
Support this project and [others by mfpiccolo][gittip-mfpiccolo] via [gittip][gittip-mfpiccolo].

[gittip-mfpiccolo]: https://www.gittip.com/mfpiccolo/

## Copyright

Copyright (c) 2013 Mike Piccolo

See [LICENSE.txt](LICENSE.txt) for details.

## Contributing

1. Fork it ( http://github.com/<my-github-username>/minitest-vcr/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/mfpiccolo/minitest-vcr/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

