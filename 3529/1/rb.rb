require 'nokogiri'
require 'json'
require 'open-uri'
require 'httparty'
require 'open_uri_redirections'


class GemHendler
	attr_reader :data_about_gem

	def initialize(github_url)
		@url = github_url
	end

	def join_all_data
		@data_about_gem = {}
		@data_about_gem[:watched_by] = find_watch_stars_forks[0].to_i
		@data_about_gem[:stars] = find_watch_stars_forks[1].to_i
		@data_about_gem[:forks] = find_watch_stars_forks[2].to_i
		@data_about_gem[:used_by] = find_used_by.to_i
		@data_about_gem[:contributers] = find_contributers.to_i
		@data_about_gem[:issues] = find_issues.to_i
	end

	def find_watch_stars_forks
		array_used_stars_forks = Array.new
		Nokogiri::HTML(open(@url,  allow_redirections: :safe)).css('.social-count').each do |element|
			array_used_stars_forks << element.text[/[\d*[:punct:]]+/].tr(",", "")
		end
		return array_used_stars_forks
	end

	def find_contributers
		contributers = Array.new
		Nokogiri::HTML(open(@url,  allow_redirections: :safe)).css('ul.numbers-summary li a span.num.text-emphasized').each do |element|
			contributers << element.text[/[\d*[:punct:]]+/].tr(",", "")
		end
		return contributers.last
	end
	#smth is wrong:( or now... 
	def find_used_by
		used_by = 0
		Nokogiri::HTML(open(@url + '/network/dependents',  allow_redirections: :safe)).css('a.btn-link.selected').each do |element|
			used_by = element.text[/[\d*[:punct:]]+/].tr(",", "")
		end
		return used_by
	end

	def find_issues
		issues = 0
		Nokogiri::HTML(open(@url + '/issues',  allow_redirections: :safe)).css('a.btn-link.selected').each do |element|
			issues = element.text[/[\d*[:punct:]]+/].tr(",", "")
		end
		return issues
	end
end

class GemsApiHendler
	attr_reader :gem_github
	attr_accessor :gem_name

	def get_github
		url = HTTParty.get("https://rubygems.org/api/v1/gems/#{@gem_name}.json")
		@gem_github = url["source_code_uri"]
	end
end


gem = GemsApiHendler.new
gem.gem_name = "nokogiri"
gem.get_github
puts gem.gem_github
gemh = GemHendler.new(gem.gem_github)
gemh.join_all_data
puts gemh.data_about_gem


