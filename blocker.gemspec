# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = "blocker"
  gem.version       = '0.0.1'
  gem.authors       = ["merkushin"]
  gem.email         = ["merkushin.m.s@gmail.com"]
  gem.description   = %q{Инструмент для синхронного выполнения операций}
  gem.summary       = %q{Инструмент для синхронного выполнения операций}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'app_config', '>= 0.0.1'
  gem.add_runtime_dependency 'redis', '>= 2.2.1'
  gem.add_runtime_dependency 'activesupport', '>= 3.0.19'
end
