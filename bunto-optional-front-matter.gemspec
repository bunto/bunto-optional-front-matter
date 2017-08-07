# encoding: utf-8

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "bunto-optional-front-matter/version"

Gem::Specification.new do |s|
  s.name          = "bunto-optional-front-matter"
  s.version       = BuntoOptionalFrontMatter::VERSION
  s.authors       = ["Ben Balter", "Suriyaa Kudo"]
  s.email         = ["ben.balter@github.com", "github@suriyaa.tk"]
  s.homepage      = "https://github.com/bunto/bunto-optional-front-matter"
  s.summary       = "A Bunto plugin to make front matter optional for Markdown files"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ["lib"]
  s.license       = "MIT"

  s.add_runtime_dependency "bunto", "~> 3.4"
  s.add_development_dependency "rspec", "~> 3.5"
  s.add_development_dependency "rubocop", "~> 0.40"
end
