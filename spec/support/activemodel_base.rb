class ActiveModel::Base
	include ActiveModel::AttributeMethods
	include ActiveModel::Validations

	def initialize(attrs={})
		attrs.each {|k, v| send("#{k}=", v) }
	end
end
