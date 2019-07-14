require_relative '../ruby_gem'
require 'json'
require 'net/http'
require 'nokogiri'
require 'open-uri'

module Parser
  # :reek:TooManyInstanceVariables
  class GitHub
    def initialize(gem_name, source_url)
      @url = source_url
      @repo = @url[%r{\/[^.:\/]+\/[^.:\/]+}]
      @gem_data = { 'name' => gem_name, 'url' => @url }
      @client_id = '26b9a6fc285e836c9f7a'
      @client_secret = '7ca0b9c0e86047afbac0951d3d505bf7801a5603'
      @auth_params = "?client_id=#{@client_id}&client_secret=#{@client_secret}"
    end

    def parse
      # Collect watched_by, stars and forks
      collect_watchers_stars_and_forks

      # Collect used_by, contributors and issues
      collect_used_by_contributors_and_issues

      # Create RubyGem object and return it
      RubyGem.new(@gem_data)
    end

    private

    # :reek:TooManyStatements
    def collect_watchers_stars_and_forks
      uri = URI("https://api.github.com/repos#{@repo}#{@auth_params}")
      response = Net::HTTP.get(uri)
      gem_repo_data = JSON.parse(response)
      @gem_data['watched_by'] = gem_repo_data['watchers'].to_i
      @gem_data['stars']      = gem_repo_data['subscribers_count'].to_i
      @gem_data['forks']      = gem_repo_data['forks'].to_i
    end

    def collect_used_by_contributors_and_issues
      collect_used_by
      collect_contributors
      collect_issues
    end

    # rubocop:disable Security/Open
    def collect_used_by
      url = "https://github.com#{@repo}/network/dependents"
      html_doc = Nokogiri::HTML(open(url).read)
      used_by = html_doc.search('a').select do |element|
        element.text =~ /Repositories/
      end[0].text
      @gem_data['used_by'] = used_by.delete(',').to_i
    end

    def collect_contributors
      url = "https://github.com#{@repo}/contributors_size"
      html_doc = Nokogiri::HTML(open(url).read)
      contributors = html_doc.search('span').text
      @gem_data['contributors'] = contributors.delete(',').to_i
    end

    # :reek:TooManyStatements
    def collect_issues
      url = "https://github.com#{@repo}/issues"
      html_doc = Nokogiri::HTML(open(url).read)
      total_issues = html_doc.search('a').select do |element|
        element.text =~ /\d+ [Open|Close]/
      end
      issues = 0
      total_issues.each { |iss| issues += iss.text.to_i }
      @gem_data['issues'] = issues.to_i
    end
    # rubocop:enable Security/Open
  end
end
