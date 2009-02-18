# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruby_bosh}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pradeep Elankumaran"]
  s.date = %q{2009-02-18}
  s.description = %q{TODO}
  s.email = %q{pradeep@intridea.com}
  s.files = ["VERSION.yml", "lib/ruby_bosh.rb", "test/ruby_bosh_test.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/skyfallsin/ruby_bosh}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{A BOSH session pre-initializer for Ruby web applications}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
