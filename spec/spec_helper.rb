require 'rubygems'
require 'rspec'
require File.join(File.dirname(__FILE__), '..', "lib", "ruby_bosh")

RSpec.configure do |config|

  config.expect_with :rspec do |c|
    c.syntax = :should
  end
  config.mock_with :rspec do |c|
    c.syntax = :should
  end

end

