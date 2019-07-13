require 'octokit'
require 'open-uri'
require 'nokogiri'
require_relative 'gem_item.rb'

class GitHubParser
  REQUEST_CONTRIBUTORS = 'a span[class=\'num text-emphasized\']'.freeze
  REQUEST_USED_BY      = 'a[class=\'btn-link selected\']'.freeze

  def initialize(token)
    @client = Octokit::Client.new(access_token: token)
    @user = @client.login
  end

  def parce(name)
    top_search = search_via_api(name)
    gem = GemItem.new
    gem = fill_the_data_from_api(gem, top_search)
    gem = fill_the_data_from_html(gem, top_search[:full_name])
    gem
  end

  def search_via_api(name)
    search_result = @client.search_repositories(name)
    search_result.items.first
  end

  def fill_the_data_from_api(gem, top_search)
    gem.name        = top_search[:name]
    gem.total_score = top_search[:score]
    gem.stars       = top_search[:watchers_count]
    gem.forks       = top_search[:forks]
    gem
  end

  def fill_the_data_from_html(gem, full_name)
    request_watchers = "li a[href=\"/#{full_name}/watchers\"]"
    request_issues   = "span a[href=\"/#{full_name}/issues\"]"
    page_repository  = Nokogiri::HTML(open("https://github.com/#{full_name}"))
    page_dependency  = Nokogiri::HTML(open("https://github.com/#{full_name}/network/dependents"))
    gem.contributors = search_in_page(REQUEST_CONTRIBUTORS, page_repository)
    gem.watchers     = search_in_page(request_watchers, page_dependency)
    gem.issues       = search_in_page(request_issues, page_dependency)
    gem.used_by      = search_in_page(REQUEST_USED_BY, page_dependency)
    gem
  end

  def search_in_page(request, page)
    raw_text = page.search(request).text
    match = raw_text.match(/(\d+)(,\d+)?/)
    match[0].sub(',', '').to_i unless match.nil?
  end
end
