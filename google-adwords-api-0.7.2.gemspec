# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "google-adwords-api"
  s.version = "0.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Danial Klimkin"]
  s.date = "2012-10-24"
  s.description = "google-adwords-api is a AdWords API client library for Ruby"
  s.email = ["api.dklimkin@gmail.com"]
  s.homepage = "http://code.google.com/p/google-api-ads-ruby/"
  s.require_paths = ["lib"]
  s.rubyforge_project = "google-adwords-api"
  s.rubygems_version = "1.8.24"
  s.summary = "Ruby Client libraries for AdWords API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<google-ads-common>, ["~> 0.8.0"])
    else
      s.add_dependency(%q<google-ads-common>, ["~> 0.8.0"])
    end
  else
    s.add_dependency(%q<google-ads-common>, ["~> 0.8.0"])
  end
end
