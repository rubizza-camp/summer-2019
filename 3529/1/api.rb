require 'json'

begin
			url = HTTParty.get("https://rubygems.org/api/v1/gems/#{@gem_name}.json")
		rescue JSON::ParserError => e
			puts "FAIL"
			return 0
		end
