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
require_relative 'DataFinder'

class GemHandler
  attr_reader :data_about_gem

  def initialize(gem_name)
    @gem_name = gem_name
    file = YAML.safe_load(File.read('login.yaml'))
    @client = Octokit::Client.new(login: file['login'], password: file['password'])
    login
  end

  def data_about_gem(url)
    data_finder = DataFinder.new(@gem_name, url, @client)
    data_finder.join_all_data
    data_finder.data_about_gem
  end

  private

  def login
    @client.auto_paginate = true
    user = @client.user
    user.login
  end
end
