# encoding: utf-8

require "padrino-helpers/tag_helpers"
require "padrino-helpers/form_helpers"
require "padrino-helpers/form_builder/abstract_form_builder"

module Padrino
	module Validation; end
end

module Padrino::Helpers::TagHelpers::HTML5
	def identity_tag_attributes
		super + [:readonly, :required]
	end
end

module Padrino::Validation::HTML5
	def text_field(field, options={})
		options.reverse_merge!(required: true)
		super
	end
end

