# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vhost_writer/version'

Gem::Specification.new do |gem|
  gem.name          = 'vhost_writer'
  gem.version       = VhostWriter::VERSION
  gem.authors       = ["Brian O'Keefe"]
  gem.email         = ['brian@bokstuff.com']
  gem.summary       = %q(Virtual host configuration generator)
  gem.description   = %q(Automatically generate virtual host config files based on a directory of sites and a given ERB template)
  gem.homepage      = 'https://github.com/brianokeefe/vhost_writer'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split
  gem.executables   = ['vhost_writer']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency 'thor'
  gem.add_development_dependency 'rspec'
end
