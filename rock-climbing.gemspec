# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rock/climbing/version'

Gem::Specification.new do |spec|
  spec.name          = "rock-climbing"
  spec.version       = Rock::Climbing::VERSION
  spec.authors       = ["Alex Selesse"]
  spec.email         = ["alex@selesse.com"]
  spec.summary       = %q{Rock climbing statistics, information, etc}
  spec.description   = %q{Not meant to be shared publicly}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.1"
end
