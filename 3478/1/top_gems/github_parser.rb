require 'octokit'
require 'open-uri'
require 'nokogiri'

class GitHubParser
  REQUEST_CONTRIBUTORS = 'a span[class=\'num text-emphasized\']'.freeze
  REQUEST_USED_BY = 'a[class=\'btn-link selected\']'.freeze

  def initialize(token)
    @client = Octokit::Client.new(access_token: token)
  end

  def parse(name)
    top_search = search_via_api(name)
    gem = {}
    gem = fill_the_data_from_api(gem, top_search)
    gem = fill_the_data_from_html(gem, top_search[:full_name])
    gem
  end

  private

  def fill_the_data_from_api(gem, top_search)
    gem[:name]        = top_search[:name]
    gem[:total_score] = top_search[:score]
    gem[:stars]       = top_search[:watchers_count]
    gem[:forks]       = top_search[:forks]
    gem
  end

  def search_via_api(name)
    search_result = @client.search_repositories(name)
    search_result.items.first
  end

  def fill_the_data_from_html(gem, full_name)
    github_main_page = Nokogiri::HTML(open("https://github.com/#{full_name}"))
    github_dependents = Nokogiri::HTML(open("https://github.com/#{full_name}/network/dependents"))
    gem = search_main(gem, github_main_page, full_name)
    gem = search_dependency(gem, github_dependents)
    gem
  end

  def search_dependency(gem, page)
    gem[:used_by] = search_in_page(REQUEST_USED_BY, page)
    gem
  end

  def search_main(gem, page, full_name)
    gem[:contributors] = search_in_page(REQUEST_CONTRIBUTORS, page)
    gem[:watchers]     = search_in_page("li a[href=\"/#{full_name}/watchers\"]", page)
    gem[:issues]       = search_in_page("span a[href=\"/#{full_name}/issues\"]", page)
    gem
  end

  def search_in_page(request, page)
    raw_text = page.search(request).text
    match = raw_text.match(/(\d+)((,\d+)?)*/)
    match[0].delete(',').to_i unless match.to_s.empty?
  end
end
