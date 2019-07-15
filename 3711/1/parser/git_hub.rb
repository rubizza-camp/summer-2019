require_relative '../ruby_gem'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'

module Parser
  class GitHub
    CLIENT_ID = '26b9a6fc285e836c9f7a'.freeze
    CLIENT_SECRET = '7ca0b9c0e86047afbac0951d3d505bf7801a5603'.freeze

    def initialize(gem_name, source_url)
      @url = source_url
      @repo = '/' + URI(@url).path.split('/')[1, 2].join('/')
      @gem_data = { 'name' => gem_name, 'url' => @url }
    end

    def parse
      collect_watchers_stars_and_forks
      collect_used_by_contributors_and_issues
      RubyGem.new(@gem_data)
    end

    private

    # --------------------------------------------------------------------------

    def collect_watchers_stars_and_forks
      response = connect_github_api
      gem_repo_data = JSON.parse(response)
      fill_watchers_stars_and_forks(gem_repo_data)
    end

    def connect_github_api
      uri = URI("https://api.github.com/repos#{@repo}")
      fill_uri_params(uri, ['client_id', CLIENT_ID], ['client_secret', CLIENT_SECRET])
      Net::HTTP.get(uri)
    end

    def fill_uri_params(uri, *param_arr)
      params = URI.decode_www_form(String(uri.query))
      param_arr.each do |key, value|
        params << [key, value]
      end
      uri.query = URI.encode_www_form(params)
    end

    def fill_watchers_stars_and_forks(gem_repo_data)
      @gem_data['watched_by'] = gem_repo_data['watchers'].to_i
      @gem_data['stars']      = gem_repo_data['subscribers_count'].to_i
      @gem_data['forks']      = gem_repo_data['forks'].to_i
    end

    # --------------------------------------------------------------------------

    def collect_used_by_contributors_and_issues
      collect_used_by
      collect_contributors
      collect_issues
    end

    def collect_used_by
      used_by = open_github_html('/network/dependents').search('a').select do |element|
        element.text =~ /Repositories/
      end[0].text
      @gem_data['used_by'] = used_by.delete(',').to_i
    end

    def collect_contributors
      contributors = open_github_html('/contributors_size').search('span').text
      @gem_data['contributors'] = contributors.delete(',').to_i
    end

    def collect_issues
      total_issues = open_github_html('/issues').search('a').select do |element|
        element.text =~ /\d+ [Open|Close]/
      end
      @gem_data['issues'] = total_issues.inject(0) do |count, issue|
        count + issue.text.to_i
      end
    end

    def open_github_html(method)
      url = "https://github.com#{@repo}#{method}"
      Nokogiri::HTML(URI.parse(url).open.read)
    end
  end
end
