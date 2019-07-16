require 'nokogiri'
require 'json'
require 'open-uri'
require 'httparty'
require 'open_uri_redirections'
require 'yaml'
require 'octokit'
require_relative 'gemhandler'

class GemsApiHendler
	attr_reader :gem_github
	attr_accessor :gem_name

	def get_github
		url = HTTParty.get("https://rubygems.org/api/v1/gems/#{@gem_name}.json")
		begin
			if url["source_code_uri"] == nil
				if url["homepage_uri"] == nil
					puts "ERROR: There is no github links on gem, named #{@gem_name}. Sorry, bro"
					return nil
				else
					@gem_github = url["homepage_uri"]
				end
			else
				@gem_github = url["source_code_uri"]
			end
		rescue JSON::ParserError => e
			puts "ERROR: There is no gem, named #{@gem_name}. Sorry, bro"
		end
	end
end

begin
	file = YAML.load(File.read("gems.yaml"))
rescue => e
	puts "ERROR: There is no file like this"
end
begin
	file["gems"].each do |gem_name|
		gem = GemsApiHendler.new
		puts gem_name
		gem.gem_name = gem_name
		if gem.get_github.nil?
			next
		end
		gemh = GemHendler.new(gem.gem_github)
		gemh.join_all_data
		puts gemh.data_about_gem
	end
rescue NoMethodError => e
	puts "ERROR: There isn't any gems in your file"
end



