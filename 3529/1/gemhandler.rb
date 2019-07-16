require 'nokogiri'
require 'json'
require 'net/http'
require 'uri'
require 'open-uri'
require 'httparty'
require 'open_uri_redirections'
require 'yaml'
require 'octokit'
require 'typhoeus'

class GemHandler
  attr_reader :data_about_gem

  def initialize(github_url, gem_name)
    @url = github_url
    @data_about_gem = {}
    @repo_addr = adress_handle
    file = YAML.safe_load(File.read('login.yaml'))
    @client = Octokit::Client.new(login: file['login'], password: file['password'])
    login
    @data_about_gem[:name] = gem_name
    join_all_data
  end

  private

  def adress_handle
    puts "Didn't find repository on github" unless @url
    @repo_addr = if @url.include?('https://github.com/')
                   @url.gsub('https://github.com/', '')
                 else
                   @url.gsub('http://github.com/', '')
                 end
  end

  def join_all_data
    find_watchers_stars_forks
    find_used_by_contributors_issues
    @data_about_gem[:rate] = make_rate
  end

  def login
    @client.auto_paginate = true
    user = @client.user
    user.login
  end

  def find_watchers_stars_forks
    find_watchers
    find_stars
    find_forks
  end

  def find_used_by_contributors_issues
    find_used_by
    find_contributers
    find_issues
  end

  def make_rate
    rate = find_watch_plus_starts + find_forks_plus_contributors
    rate + @data_about_gem[:issues] * 0.05 + @data_about_gem[:used_by] * 0.5
  end

  def find_watch_plus_starts
    @data_about_gem[:watched_by] * 0.15 + @data_about_gem[:stars] * 0.15
  end

  def find_forks_plus_contributors
    @data_about_gem[:watched_by] * 0.15 + @data_about_gem[:stars] * 0.15
  end

  def find_forks
    repo = @client.repo(@repo_addr)
    @data_about_gem[:forks] = repo[:forks_count]
  end

  def find_stars
    repo = @client.repo(@repo_addr)
    @data_about_gem[:stars] = repo[:stargazers_count]
  end

  def find_watchers
    repo = @client.repo(@repo_addr)
    @data_about_gem[:watched_by] = repo[:subscribers_count]
  end

  def find_contributers
    contr = @client.contributors(@repo_addr)
    @data_about_gem[:contributers] = contr.length
  end

  def find_used_by
    request = Typhoeus::Request.new(@url + '/network/dependents', followlocation: true)
    request.run
    noko_obj = Nokogiri::HTML(request.response.body)
    noko_obj.css('a.btn-link.selected').each do |element|
      @data_about_gem[:used_by] = element.text[/[\d*[:punct:]]+/].tr(',', '').to_i
    end
  end

  def find_issues
    request = Typhoeus::Request.new(@url + '/issues', followlocation: true)
    request.run
    noko_obj = Nokogiri::HTML(request.response.body)
    noko_obj.css('a.btn-link.selected').each do |element|
      @data_about_gem[:issues] = element.text[/[\d*[:punct:]]+/].tr(',', '').to_i
    end
  end
end
