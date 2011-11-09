# encoding: utf-8

require 'rubygems'
require 'spork'

Spork.prefork do
	require "bundler/setup"
	Bundler.setup(:default)
	require "rspec"
	require "nokogiri"
	require "active_model"
	require "padrino-helpers"
	require "padrino/validation/html5"

	pwd = File.dirname(__FILE__)
	$: << File.expand_path(pwd + '/../lib')

	Dir["#{pwd}/support/**/*.rb"].each {|_| require File.expand_path(_) }
end

Spork.each_run do
end

