# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rails-excel/version"

Gem::Specification.new do |s|
  s.name        = "rails-excel"
  s.version     = Rails::Excel::VERSION
  s.authors     = ["Ramihajamalala Hery"]
  s.email       = ["hery@weborama.com"]
  s.homepage    = ""
  s.summary     = %q{A rails gem to write excel}
  s.description = %q{Use different strategies to write excel : available are :spreadsheet and :writeexcel
    This implements rxls template in your rails view
  }

  s.rubyforge_project = "rails-excel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
