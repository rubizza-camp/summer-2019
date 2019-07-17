require_relative '../ruby_gem'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'

module Parser
  class Repo
    CLIENT_ID = '26b9a6fc285e836c9f7a'.freeze
    CLIENT_SECRET = '7ca0b9c0e86047afbac0951d3d505bf7801a5603'.freeze

    def initialize(name)
      @name = name
      @data = {}
    end

    def parse
      search_gem && parse_gem_page
    end

    private

    def search_gem
      search_params = { q: "#{@name}+language:ruby", sort: 'stars' }
      response = connect_github_api('/search/repositories', search_params)
      json = JSON.parse(response)
      fill_gem_attrs(json['items'].first) if json['total_count'].positive?
    end

    def connect_github_api(path, params)
      uri = URI("https://api.github.com#{path}")
      fill_uri_params(uri, params)
      Net::HTTP.get(uri)
    end

    def fill_uri_params(uri, params = {})
      params[:client_id] = CLIENT_ID
      params[:client_secret] = CLIENT_SECRET
      uri.query = URI.encode_www_form(params)
    end

    def fill_gem_attrs(gem_data)
      @data[:name] = gem_data['name']
      @data[:html_url] = gem_data['html_url']
      @data[:watched_by] = gem_data['watchers'].to_i
      @data[:stars] = gem_data['stargazers_count'].to_i
      @data[:forks] = gem_data['forks'].to_i
    end

    def parse_gem_page
      collect_used_by
      collect_contributors
      collect_issues
      @data
    end

    def collect_used_by
      used_by = open_github_html('/network/dependents').search('a').select do |element|
        element.text =~ /Repositories/
      end[0].text
      @data[:used_by] = used_by.delete(',').to_i
    end

    def collect_contributors
      contributors = open_github_html('/contributors_size').search('span').text
      @data[:contributors] = contributors.delete(',').to_i
    end

    def collect_issues
      total_issues = open_github_html('/issues').search('a').select do |element|
        element.text =~ /\d+ [Open|Close]/
      end
      @data[:issues] = total_issues.map { |issue| issue.text.to_i }.sum
    end

    def open_github_html(method)
      uri = URI(@data[:html_url] + method)
      fill_uri_params(uri)
      Nokogiri::HTML(uri.open.read)
    end
  end
end
