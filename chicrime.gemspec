# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chicrime/version'

Gem::Specification.new do |spec|
  spec.name          = "chicrime"
  spec.version       = Chicrime::VERSION
  spec.authors       = ["Cody Roberts"]
  spec.email         = ["codyjroberts@gmail.com"]

  spec.summary       = %q{Chicrime is a ruby gem that wraps the soda-ruby library with easy to use methods and  a DSL. The purpose of Chicrime is to enable users to easily access Chicago's crime data.}
  spec.homepage      = "http://www.github.com/bloomyminded/chicrime"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3", '>= 3.3.0'
  spec.add_development_dependency "rspec-its", "~> 1.2", '>= 1.2.0'
  spec.add_development_dependency "guard", "~> 2.13", '>= 2.13.0'
  spec.add_development_dependency "guard-rspec", "~> 4.6", '>= 4.6.0'
  spec.add_development_dependency "fuubar", "~> 2.0", '>= 2.0.0'
  spec.add_development_dependency "pry", "~> 0.10", ">= 0.10.1"
  spec.add_development_dependency "coveralls", '~> 0.8', ">= 0.8.2"

  spec.add_runtime_dependency "soda-ruby", "~> 0.2.13"
end
