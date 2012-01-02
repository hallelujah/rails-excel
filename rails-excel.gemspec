# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails-excel/version"

Gem::Specification.new do |s|
  s.name        = "rails-excel"
  s.version     = RailsExcel::VERSION
  s.authors     = ["Ramihajamalala Hery"]
  s.email       = ["hery@rails-royce.org"]
  s.homepage    = "https://github.com/hallelujah/rails-excel"
  s.summary     = %q{A rails gem to write excel}
  s.description = %q{Use different strategies to write excel : available are :spreadsheet and :writeexcel
    This implements rxls template in your rails view
  }

  s.rubyforge_project = "rails-excel"

  s.add_development_dependency 'rake', '= 0.8.7'
  s.add_development_dependency 'rspec', '~> 2.3.0'
  s.add_development_dependency 'rcov', '~> 0.9.9'
  s.add_development_dependency 'actionpack', '~> 2.3.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
