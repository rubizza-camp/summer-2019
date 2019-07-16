require 'nokogiri'
require 'json'
require 'open-uri'
require 'httparty'
require 'open_uri_redirections'
require 'yaml'
require 'octokit'

class GemHendler
	attr_reader :data_about_gem

	def initialize(github_url)
		@url = github_url
		if @url.nil?
			"Didn't find repository on github"
			return :fail
		end
		if @url.include?("https://github.com/")
			@repo_addr = @url.gsub("https://github.com/", "")
		else
			@repo_addr = @url.gsub("http://github.com/", "")
		end
		@client = Octokit::Client.new(:login => 'gannagoodkevich', :password => 'Pusivill1999')
		user = @client.user
		@client.auto_paginate = true
	end

	def join_all_data
		@data_about_gem = {}
		@data_about_gem[:watched_by] = find_watchers
		@data_about_gem[:stars] = find_stars
		@data_about_gem[:forks] = find_forks
		@data_about_gem[:used_by] = find_used_by.to_i
		@data_about_gem[:contributers] = find_contributers
		@data_about_gem[:issues] = find_issues.to_i
	end

	def find_forks
		repo = @client.repo @repo_addr
		return repo[:forks_count]
	end

	def find_stars
		repo = @client.repo @repo_addr
		return repo[:stargazers_count]
	end

	def find_watchers
		repo = @client.repo @repo_addr
		return repo[:subscribers_count]
	end

	def find_contributers
		contr = @client.contributors @repo_addr
		return contr.length
	end

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

