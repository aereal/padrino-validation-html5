# encoding: utf-8

require "bundler/setup"
Bundler.setup(:default, :test, :development)
Bundler.require(:default, :test, :development)

Spork.prefork do
	require "padrino-helpers"
	require "padrino/validation/html5"

	pwd = File.dirname(__FILE__)
	$: << File.expand_path(pwd + '/../lib')

	Dir["#{pwd}/support/**/*.rb"].each {|_| require File.expand_path(_) }

	RSpec.configure do |config|
		config.include Padrino::Helpers::TagHelpers
		config.include Padrino::Helpers::OutputHelpers
		config.include Padrino::Helpers::AssetTagHelpers
		config.include Padrino::Helpers::FormHelpers
		config.include Padrino::Validation::HTML5::ExtendedHelpers
	end
end

Spork.each_run do
end

