# Author:: MinixLi (gmail: MinixLi1986)
# Homepage:: http://citrus.inspawn.com
# Date:: 15 July 2014

$:.push File.expand_path('../lib', __FILE__)

require 'citrus-scheduler/version'

Gem::Specification.new do |spec|
  spec.name        = 'citrus-scheduler'
  spec.version     = CitrusScheduler::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['MinixLi']
  spec.email       = 'MinixLi1986@gmail.com'
  spec.description = %q{Citrus Scheduler}
  spec.summary     = %q{Citrus Scheduler}
  spec.homepage    = 'http://citrus.inspawn.com'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency('algorithms')
  spec.add_dependency('eventmachine')
end
