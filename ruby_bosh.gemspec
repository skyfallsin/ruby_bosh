Gem::Specification.new do |s|
  s.name = "mikemarsian-ruby_bosh"
  s.version = "0.13.1"

  s.require_paths = ["lib"]
  s.authors = ["Original author: Pradeep Elankumaran. Update for ruby 2: Mike Polischuk"]
  s.date = "2016-07-27"
  s.description = "An XMPP BOSH session pre-initializer for Ruby web applications"
  s.email = "mike@polischuk.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README"
  ]
  s.licenses = ['MIT']
  s.files = [
    "LICENSE",
    "README",
    "Rakefile",
    "autotest/discover.rb",
    "lib/ruby_bosh.rb",
    "ruby_bosh.gemspec",
    "spec/ruby_bosh_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.homepage = "http://github.com/mikemarsian/ruby_bosh"
  s.summary = "A BOSH session pre-initializer for Ruby web applications (for Ruby 2+)"
  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", '~> 3.0'
  s.add_development_dependency "rspec_junit_formatter", '0.2.2'

  s.add_dependency "builder", "~> 3.0"
  s.add_dependency "rest-client" , "~> 1.8"
  s.add_dependency "hpricot", "~> 0.8"

end

