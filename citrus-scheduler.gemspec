# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 15 July 2014

$:.push File.expand_path('../lib', __FILE__)

require 'citrus-scheduler/version'

Gem::Specification.new do |spec|
  spec.name        = 'pomelo-citrus-scheduler'
  spec.version     = CitrusScheduler::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['MinixLi']
  spec.email       = 'MinixLi1986@gmail.com'
  spec.description = %q{pomelo-citrus-scheduler is a simple clone of pomelo-scheduler, it is a schedule tool and provide a schedule module which is highly efficient and can support large number job schedule}
  spec.summary     = %q{pomelo-scheduler clone written in Ruby using EventMachine}
  spec.homepage    = 'https://github.com/minixli/pomelo-citrus-scheduler'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency('algorithms', '~> 0')
  spec.add_dependency('eventmachine', '~> 0')
end
