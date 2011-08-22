Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'synergy_1c7_connector'
  s.version     = '0.1'
  s.summary     = 'Add importing feature of 1C 7.7 XML files'
  # s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'Pavel Belyakov (Service & Consulting)'
  s.email             = 'service@secoint.ru'
  s.homepage          = 'http://github.com/secoint/synergy_1c7_connector'
  s.rubyforge_project = 'synergy_1c7_connector'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>= 0.60.1')
end
