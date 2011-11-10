# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "padrino/validation/html5/version"

Gem::Specification.new do |s|
	s.name        = "padrino-validation-html5"
	s.version     = Padrino::Validation::HTML5::VERSION
	s.authors     = ["AOKI Hanae"]
	s.email       = ["aereal@kerare.org"]
	s.homepage    = "https://github.com/aereal/padrino-validation-html5"
	s.summary     = %q{automatically add client-side validations}
	s.description = %q{automatically add client-side validations}

	s.files         = `git ls-files`.split("\n")
	s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
	s.require_paths = ["lib"]

	s.add_runtime_dependency "padrino-helpers"
	s.add_development_dependency "rake"
	s.add_development_dependency "rspec"
	s.add_development_dependency "activemodel"
	s.add_development_dependency "nokogiri"
end
