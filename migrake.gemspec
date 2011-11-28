# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "migrake/version"

Gem::Specification.new do |s|
  s.name        = "migrake"
  s.version     = Migrake::VERSION
  s.authors     = ["Navneet"]
  s.email       = ["navneetk@thoughtworks.com"]
  s.homepage    = ""
  s.summary     = %q{Run all versioned custom rake tasks using this gem }
  s.description = %q{It automates the process of invoking rake tasks and maintains the status of cutom rake tasks}

  s.rubyforge_project = "migrake"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
