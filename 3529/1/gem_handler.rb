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
require_relative 'data_finder'
require_relative 'api_handler'

class GemHandler
  def initialize(gem)
    @gem = gem
    file = YAML.safe_load(File.read('login.yaml'))
    @client = Octokit::Client.new(login: file['login'], password: file['password'])
  end

  def data_about_gem
    login
    data_finder = DataFinder.new(@gem.gem_name, @gem.find_github_link, @client)
    data_finder.make_rate
    data_finder.data_about_gem
  end

  private

  def login
    @client.auto_paginate = true
    user = @client.user
    user.login
  end
end
