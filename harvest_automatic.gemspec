# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harvest_automatic/version'

Gem::Specification.new do |spec|
  spec.name          = "harvest_automatic"
  spec.version       = HarvestAutomatic::VERSION
  spec.authors       = ["Justin Grubbs"]
  spec.email         = ["justin@jgrubbs.net"]

  spec.summary       = %q{Automatically submit hours to Harvest App}
  spec.homepage      = "http://github.com/jGRUBBS/harvest_automatic"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ['harvest']
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 1.8.3"
  spec.add_dependency "harvested", "~> 3.1.1"
  spec.add_dependency "highline", "~> 1.7.8"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "awesome_print"
end
