# encoding: utf-8

describe Padrino::Validation::HTML5 do
	include Padrino::Helpers::OutputHelpers
	include Padrino::Helpers::TagHelpers
	include Padrino::Helpers::AssetTagHelpers
	include Padrino::Helpers::FormHelpers
	include Padrino::Validation::HTML5::ExtendedHelpers

	before do
		Padrino::Helpers::FormBuilder::StandardFormBuilder.send :include, Padrino::Validation::HTML5
		class Model < ActiveModel::Base
			@attrs = [:name, :age]
			define_attribute_methods @attrs
			attr_accessor *@attrs
		end
	end

	context "when model has field which should be present" do
		before do
			Model.validates_presence_of :name
		end

		it "injects `required' attribute to `input' element" do
			form_for(Model.new, '/register') {|f| f.text_field :name }.
				should have_tag('input', required: 'required')
		end
	end

	context "when model has field which restricted max length" do
		before do
			Model.validates_length_of :name, maximum: 255
		end

		it "injects `maxlength' attribute to `input' element" do
			form_for(Model.new, '/register') {|f| f.text_field :name }.
				should have_tag('input', maxlength: '255')
		end
	end

	context "when model has field which is inclusive of any range" do
		before do
			Model.validates_inclusion_of :age, in: 20..30
		end

		it "injects `max' attribute to element" do
			form_for(Model.new, '/register') {|f| f.text_field :age }.
				should have_tag('input', max: '30', min: '20')
		end
	end
end
