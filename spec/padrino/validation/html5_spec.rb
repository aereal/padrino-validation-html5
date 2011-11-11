# encoding: utf-8

describe Padrino::Validation::HTML5 do
	before do
		Padrino::Helpers::FormBuilder::StandardFormBuilder.send :include, Padrino::Validation::HTML5
		class User < ActiveModel::Base
			@attrs = [:name, :age]
			define_attribute_methods @attrs
			attr_accessor *@attrs
		end
	end

	context "when model has field which should be present" do
		before do
			User.validates_presence_of :name
		end

		subject do
			form_for(User.new, '/register') {|f| f.text_field :name }
		end

		it "injects `required' attribute to `input' element" do
			should have_tag('input', required: 'required')
		end
	end

	context "when model has field which restricted max length" do
		before do
			User.validates_length_of :name, maximum: 255
		end

		subject do
			form_for(User.new, '/register') {|f| f.text_field :name }
		end

		it "injects `maxlength' attribute to `input' element" do
			should have_tag('input', maxlength: '255')
		end
	end

	context "when model has field which is inclusive of any range" do
		before do
			User.validates_inclusion_of :age, in: 20..30
		end

		subject do
			form_for(User.new, '/register') {|f| f.text_field :age }
		end

		it "injects `max' attribute to element" do
			should have_tag('input', max: '30', min: '20')
		end
	end
end
