require 'octokit'
require 'optparse'
require 'mechanize'
# rubocop:disable Security/Open
module Repo
  class Parser
    REQUEST_CONTRIBUTORS = 'a span[class=\'num text-emphasized\']'.freeze
    REQUEST_USED_BY = 'a[class=\'btn-link selected\']'.freeze

    attr_reader :repo

    def initialize(repo:)
      @repo = repo
    end

    def parse
      hash = {}
      hash = find_api_params(hash)
      find_html_params(hash)
    end

    def find_api_params(hash)
      hash[:name] = @repo[:name]
      hash[:total_score] = @repo[:score]
      hash[:stars] = @repo[:watchers_count]
      hash[:forks] = @repo[:forks]
      hash
    end

    def find_html_params(hash)
      github_main_page = Nokogiri::HTML(open("https://github.com/#{@repo[:full_name]}"))
      github_dependents = Nokogiri::HTML(open('https://github.com/' + @repo[:full_name] + '/network/dependents')) # rubocop:disable Metrics/LineLength
      hash = search_main(hash, github_main_page)
      hash = search_dependency(hash, github_dependents)
      hash
    end

    def search_dependency(hash, page)
      hash[:used_by] = search_in_page(REQUEST_USED_BY, page)
      hash
    end

    def search_main(hash, page)
      hash[:contributors] = search_in_page(REQUEST_CONTRIBUTORS, page)
      hash[:watchers] = search_in_page("li a[href=\"/#{@repo[:full_name]}/watchers\"]", page)
      hash[:issues] = search_in_page("span a[href=\"/#{@repo[:full_name]}/issues\"]", page)
      hash
    end

    def search_in_page(request, page)
      raw_text = page.search(request).text
      match = raw_text.match(/(\d+)((,\d+)?)*/)
      match[0].delete(',').to_i unless match.to_s.empty?
    end
  end
end
# rubocop:enable Security/Open
