# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb2/version'

Gem::Specification.new do |spec|
  spec.name          = 'fb2'
  spec.version       = Fb2::VERSION
  spec.authors       = ['Andrey Zinenko']
  spec.email         = ['andrew@izinenko.ru']

  spec.summary       = 'fb2 sax parser'
  spec.description   = 'FictionBook parser'
  spec.homepage      = 'https://github.com/zinenko/fb2'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'ox',     '>= 2.8'
  spec.add_runtime_dependency 'aasm',   '>= 4.0'
  spec.add_runtime_dependency 'virtus', '>= 1.0'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'pry',     '>= 0.10'
  spec.add_development_dependency 'rake',    '>= 10.0'
  spec.add_development_dependency 'rspec',   '>= 3.0'
  spec.add_development_dependency 'rubocop', '0.32.1'
end
