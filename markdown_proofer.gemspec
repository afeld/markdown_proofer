# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'markdown_proofer/version'

Gem::Specification.new do |spec|
  spec.name          = 'markdown_proofer'
  spec.version       = MarkdownProofer::VERSION
  spec.authors       = ['Aidan Feldman']
  spec.email         = ['aidan.feldman@gmail.com']
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = 'https://github.com/afeld/markdown_proofer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'guard', '~> 2.6'
  spec.add_development_dependency 'guard-rspec', '~> 4.2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
