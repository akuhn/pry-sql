# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-sql/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-sql"
  spec.version       = PrySQL::VERSION
  spec.authors       = ["Adrian Kuhn"]
  spec.email         = ["akuhn@iam.unibe.ch"]

  spec.summary       = "Execute SQL commands from the pry command line."
  spec.homepage      = "https://github.com/akuhn/pry-sql"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
