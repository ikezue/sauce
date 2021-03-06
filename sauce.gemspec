# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sauce/version'

Gem::Specification.new do |gem|
  gem.name          = 'sauce'
  gem.version       = Sauce::VERSION
  gem.authors       = ['ikezue']
  gem.email         = ['ikezue@gmail.com']
  gem.description   = %q{A project generator similar to Rails generators}
  gem.summary       = gem.description
  gem.homepage      = 'https://bitbucket.com/ikezue/sauce'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency              'path',           '~> 1.3.3'
  gem.add_dependency              'safe_yaml',      '~> 0.9.7'
  gem.add_dependency              'settingslogic',  '~> 2.0.9'
  gem.add_dependency              'thor-tree',      '~> 0.2.0'

  gem.add_development_dependency  'aruba',          '~> 0.5.4'
  gem.add_development_dependency  'bundler',        '~> 1.5.2'
  gem.add_development_dependency  'cucumber',       '~> 1.3.10'
  gem.add_development_dependency  'rake',           '~> 10.1.1'
  gem.add_development_dependency  'rspec',          '~> 2.14.1'

  gem.add_development_dependency 'rvm-with'

  # Meteor app generation
  gem.add_dependency              'compass'
  gem.add_dependency              'zurb-foundation'

  # Rails app generation
  gem.add_dependency              'rails',          '4.1.0.beta1'
end
