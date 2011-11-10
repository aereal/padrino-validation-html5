source "http://rubygems.org"

gemspec

group :test do
	group :automated do
		gem 'spork', '>= 0.9.0.rc9'
		gem 'guard-spork'
		gem 'guard-rspec'

		if /darwin/ === RUBY_PLATFORM
			gem 'rb-fsevent'
			gem 'ruby_gntp'
		end
	end
end
