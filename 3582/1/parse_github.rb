# frozen_string_literal: true

require 'httparty'
require 'nokogiri'
require 'open-uri'
require 'pry'
require 'uri'

# Parse
class ParseGithub
  attr_reader :params, :api, :gem_name

  def initialize(gem_name)
    @api = { r_gems: 'https://rubygems.org/api/v1/gems/', github: 'https://api.github.com/repos/' }
    @params = {}
    @gem_name = gem_name
    @uri = ''
  end

  def fun
    fetch_uri
    @params[:forks] = parse_api(@uri, 'forks_count')
    @params[:watchers] = parse_api(@uri, 'subscribers_count')
    @params[:stars] = parse_api(@uri, 'stargazers_count')
    params
  end

  def fetch_uri
    uri = HTTParty.get([@api[:r_gems], @gem_name, '.json'].join)
    urius = URI(uri['source_code_uri'])
    urius.scheme = 'https'
    @uri = urius.to_s
    parse_hard_params
  end

  private

  def parse_api(location, selector)
    location.slice! 'https://github.com/'
    headers = {
      'Authorization' => 'token 88cd131ae9b1155f131a59f701f6df8e1fe2c696',
      'User-Agent' => 'Httparty'
    }
    response = HTTParty.get([@api[:github], location].join, headers: headers)
    response[selector]
  end

  def parse_light_params
    doc = Nokogiri::HTML(::Kernel.open(@uri))
    @params[:contributors] = doc.css("span[class='num text-emphasized']")
    @params[:contributors] = @params[:contributors].last.text.tr('^0-9', '')
    @params[:issues] = doc.css("span[class='Counter']")
    @params[:issues] = @params[:issues].first.text
  end

  def parse_hard_params
    doc = Nokogiri::HTML(::Kernel.open([@uri, '/network/dependents'].join))
    params[:used_by] = doc.css('.btn-link').css('.selected')
    params[:used_by] = @params[:used_by].text.tr('^0-9', '')
    parse_light_params
  end
end

ParseGithub.new('sinatra').fun
