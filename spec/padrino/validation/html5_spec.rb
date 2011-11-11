# encoding: utf-8

describe Padrino::Validation::HTML5 do
	before do
		@request_path = '/register'
		Padrino::Helpers::FormBuilder::StandardFormBuilder.send :include, Padrino::Validation::HTML5
	end

	let(:model) {
		User ||= Class.new(ActiveModel::Base) do
			@attrs = [:name, :age]
			define_attribute_methods @attrs
			attr_accessor *@attrs
		end
	}
	let!(:model_instance) { model.new }
	let(:template_builder) { builder_instance(model_instance) }
	let(:field_id) { template_builder.send(:field_id, attribute) }

	context "when model has field which should be present" do
		before do
			model.validates_presence_of attribute
		end

		let(:attribute) { :name }

		subject do
			form_for(model_instance, @request_path) {|f| f.text_field attribute }
		end

		it "injects `required' attribute to `input' element" do
			should have_tag('input', id: field_id, required: 'required')
		end
	end

	context "when model has field which restricted max length" do
		before do
			model.validates_length_of attribute, maximum: 255
		end

		let(:attribute) { :name }

		subject do
			form_for(model_instance, @request_path) {|f| f.text_field attribute }
		end

		it "injects `maxlength' attribute to `input' element" do
			should have_tag('input', id: field_id, maxlength: '255')
		end
	end

	context "when model has field which is inclusive of any range" do
		before do
			model.validates_inclusion_of attribute, in: 20..30
		end

		let(:attribute) { :age }

		subject do
			form_for(model_instance, @request_path) {|f| f.text_field attribute }
		end

		it "injects `max' attribute to element" do
			should have_tag('input', id: field_id, max: '30', min: '20')
		end
	end
end
