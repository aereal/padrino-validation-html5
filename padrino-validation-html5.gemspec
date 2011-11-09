# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "padrino/validation/html5/version"

Gem::Specification.new do |s|
	s.name        = "padrino-validation-html5"
	s.version     = Padrino::Validation::HTML5::VERSION
	s.authors     = ["AOKI Hanae"]
	s.email       = ["aereal@kerare.org"]
	s.homepage    = ""
	s.summary     = %q{TODO: Write a gem summary}
	s.description = %q{TODO: Write a gem description}

	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ["lib"]

	s.add_runtime_dependency "padrino-helpers"
	s.add_development_dependency "rake"
	s.add_development_dependency "rspec"
	s.add_development_dependency "activemodel"
	s.add_development_dependency "nokogiri"
end
