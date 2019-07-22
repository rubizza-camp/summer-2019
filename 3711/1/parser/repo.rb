require_relative '../ruby_gem'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'

module Parser
  class Repo
    CLIENT_ID = ENV['CLIENT_ID'].freeze
    CLIENT_SECRET = ENV['CLIENT_SECRET'].freeze

    def initialize(name)
      @name = name
      @data = {}
      search_gem
    end

    def parse
      parse_gem_page
    end

    private

    def search_gem
      search_params = { q: "#{@name}+language:ruby", sort: 'stars' }
      response = connect_github_api('/search/repositories', search_params)
      json = JSON.parse(response)
      fill_gem_attrs(json['items'].first) if json['total_count'].positive?
    end

    def connect_github_api(path, params)
      send_get_request("https://api.github.com#{path}", params)
    end

    def fill_gem_attrs(gem_data)
      @data[:name] = gem_data['name']
      @data[:html_url] = gem_data['html_url']
      @data[:stars] = gem_data['stargazers_count'].to_i
      @data[:forks] = gem_data['forks'].to_i
    end

    def parse_gem_page
      collect_used_by
      collect_contributors
      collect_issues
      collect_watched_by
      @data
    end

    def collect_used_by
      used_by = search_tag_on_github_repo('/network/dependents', 'a').select do |element|
        element.text =~ /Repositories/
      end[0].text
      @data[:used_by] = used_by.delete(',').to_i
    end

    def collect_contributors
      contributors = search_tag_on_github_repo('/contributors_size', 'span').text
      @data[:contributors] = contributors.delete(',').to_i
    end

    def collect_issues
      total_issues = search_tag_on_github_repo('/issues', 'a').select do |element|
        element.text =~ /\d+ [Open|Close]/
      end
      @data[:issues] = total_issues.map { |issue| issue.text.to_i }.sum
    end

    def collect_watched_by
      dom = open_github_html('')
      @data[:watched_by] = dom.css('ul.pagehead-actions a')[1].text.delete(',').to_i
    end

    def open_github_html(method)
      Nokogiri::HTML(send_get_request(@data[:html_url] + method))
    end

    def search_tag_on_github_repo(method, tag)
      open_github_html(method).search(tag)
    end

    def send_get_request(url, params = {})
      uri = URI(url)
      fill_uri_params(uri, params)
      Net::HTTP.get(uri)
    end

    def fill_uri_params(uri, params = {})
      params[:client_id] = CLIENT_ID if CLIENT_ID
      params[:client_secret] = CLIENT_SECRET if CLIENT_SECRET
      uri.query = URI.encode_www_form(params)
    end
  end
end
