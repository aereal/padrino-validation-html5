require "nokogiri"

RSpec::Matchers.define :have_tag do |expected_tag, options={}|
	match do |actual|
		@expected_tag = expected_tag
		@options = options
		matched = nokogiri(actual)

		if options[:count]
			matched.size == options[:count].to_i
		else
			matched.any?
		end
	end

	failure_message_for_should do |actual|
		"expected following output to contain a #{tag_inspect} tag:\n#{@document}"
	end

	failure_message_for_should_not do |actual|
		"expected following output to omit a #{tag_inspect}:\n#{@document}"
	end

	def nokogiri(str)
		q = Nokogiri::CSS.parse(@expected_tag.to_s).map(&:to_xpath).first
		@query = Nokogiri::XML::NodeSet === str ? q.gsub(%r|^//|, './/') : q

		add_options_conditions_to!(@query)

		@document =
			case str
			when Nokogiri::HTML::Document, Nokogiri::XML::NodeSet
				str
			when str.respond_to?(:body)
				Nokogiri::HTML(str.body.to_s)
			else
				Nokogiri::HTML(str.to_s)
			end
		@document.xpath(*@query)
	end

	def xpath_escape(str)
		if str.include?("'")
			if str.include?('"')
				parts = str.split("'").map {|part| "'#{part}'" }
				"concat(#{parts.join(%|, "'", |)})"
			else
				%|"#{str}"|
			end
		else
			"'#{str}'"
		end
	end

	def tag_inspect
		html = "<#{@expected_tag}"

		@options.reject {|k, v| [:content, :count].include? k }.each do |k, v|
			html << %| #{k}="#{v}"|
		end

		if @options[:content]
			html << ">#{@options[:content]}</#{@expected_tag}>"
		else
			html << "/>"
		end

		html
	end

	def add_attributes_conditions_to!(query)
		attribute_conditions = []

		@options.reject {|k, v| [:content, :count].include? k }.each do |k, v|
			attribute_conditions << "@#{k} = #{xpath_escape(v)}"
		end

		unless attribute_conditions.none?
			query << "[#{attribute_conditions.join(' and ')}]"
		end
	end

	def add_content_condition_to!(query)
		if @options[:content]
			query << "[contains(., #{xpath_escape(@options[:content])})]"
		end
	end

	def add_options_conditions_to!(query)
		add_attributes_conditions_to!(query)
		add_content_condition_to!(query)
	end
end
