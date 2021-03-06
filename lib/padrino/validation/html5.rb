# encoding: utf-8

require "padrino-helpers/tag_helpers"
require "padrino-helpers/form_helpers"
require "padrino-helpers/form_builder/abstract_form_builder"

module Padrino
	module Validation; end
end

module Padrino::Validation::HTML5
	module ExtendedHelpers
		private
		def identity_tag_attributes
			super + [:readonly, :required, :autofocus, :novalidate, :formnovalidate, :multiple]
		end
	end

	class << self
		def registered(app)
			builder = Padrino::Helpers::FormBuilder.const_get(app.settings.default_builder)
			builder.send :include, self
			Padrino::Helpers::TagHelpers.instance_eval do
				alias_method :__identity_tag_attributes, :identity_tag_attributes
				def identity_tag_attributes
					__identity_tag_attributes + [:readonly, :required, :autofocus, :novalidate, :formnovalidate, :multiple]
				end
			end
		end

		def included(subj)
			subj.field_types.each {|field|
				define_method(field) {|field, options={}| options = inject_validations(field, options); super(field, options) }
			}
		end
	end

	def inject_validations(field, options={})
		validators = object.class.validators_on(field).
			group_by(&:kind).
			map {|kind, validators| [kind, validators.map(&:options).inject(&:merge)] }
		validators.each do |kind, opts|
			case kind
			when :presence
				options.reverse_merge!(required: true)
			when :length
				attrs = {}
				if opts[:is]
					attrs[:minlength] = attrs[:maxlength] = opts[:is]
				else
					attrs[:minlength] = [opts[:minimum], opts[:within].try(:first)].compact.max
					attrs[:maxlength] = [opts[:maximum], opts[:within].try(:last)].compact.min
				end
				options.reverse_merge!(attrs.reject {|_, v| v.blank? })
			when :inclusion
				if opts[:in].respond_to?(:first) && opts[:in].respond_to?(:last)
					attrs = {
						min: opts[:in].first,
						max: opts[:in].last
					}
					options.reverse_merge!(attrs.reject {|_, v| v.blank? })
				end
			end
		end
		options
	end
end

