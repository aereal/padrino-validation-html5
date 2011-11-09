# encoding: utf-8

describe Padrino::Validation::HTML5 do
	include Padrino::Helpers::OutputHelpers
	include Padrino::Helpers::TagHelpers
	include Padrino::Helpers::TagHelpers::HTML5
	include Padrino::Helpers::AssetTagHelpers
	include Padrino::Helpers::FormHelpers

	before do
		Padrino::Helpers::FormBuilder::StandardFormBuilder.send :include, Padrino::Validation::HTML5
		class Model < ActiveModel::Base; end
	end

	context "when model has field which should be present" do
		before do
			Model.define_attribute_methods [:name]
			Model.send :attr_accessor, :name
			Model.validates_presence_of :name
		end

		it "injects `required' attribute to `input' element" do
			form_for(Model.new, '/register') {|f| f.text_field :name }.
				should have_tag('input', required: 'required')
		end
	end
end
