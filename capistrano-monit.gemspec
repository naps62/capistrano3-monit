# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "capistrano3-monit"
  gem.version       = '0.1.0'
  gem.authors       = ["Miguel Palhas"]
  gem.email         = ["mpalhas@gmail.com"]
  gem.description   = %q{Monit integration for Capistrano 3}
  gem.summary       = %q{Monit integration for Capistrano 3}
  gem.homepage      = "https://github.com/naps62/capistrano3-monit"

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'capistrano', '~> 3.0'
  gem.add_dependency 'sshkit', '~> 1.2.0'

end
