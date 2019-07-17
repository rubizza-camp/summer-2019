# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# parsing all information from github api
class Parser
  REQUEST_CONTRIBUTORS = 'a span[class=\'num text-emphasized\']'
  REQUEST_USED_BY = 'a[class=\'btn-link selected\']'

  def initialize(gem)
    @client = Octokit::Client.new(access_token: gem)
  end

  def parse(name)
    all_gems = {}
    top_search = search_api(name)
    all_gems = filling_the_data_from_api(all_gems, top_search)
    all_gems = filling_the_data(all_gems, top_search[:full_name])
    all_gems
  end

  private

  def filling_the_data_from_api(all_gems, top_search)
    all_gems[:name] = top_search[:name]
    all_gems[:stars] = top_search[:watchers_count]
    all_gems[:forks] = top_search[:forks]
    all_gems
  end

  def search_in_html(request, page)
    raw_text = page.search(request).text
    match = raw_text.match(/(\d+)((,\d+)?)*/)
    match[0].delete(',').to_i unless match.to_s.empty?
  end

  def search_main(all_gems, page, full_name)
    all_gems[:contributors] = search_in_html(REQUEST_CONTRIBUTORS, page)
    all_gems[:watchers] = search_in_html("li a[href=\"/#{full_name}/watchers\"]", page)
    all_gems[:issues] = search_in_html("span a[href=\"/#{full_name}/issues\"]", page)
    all_gems
  end

  def search_api(name)
    search = @client.search_repositories(name)
    search.items.first
  end

  def filling_the_data(all_gems, full_name)
    github_page = Nokogiri::HTML(open("https://github.com/#{full_name}"))
    github_dep = Nokogiri::HTML(open("https://github.com/#{full_name}/network/dependents"))
    all_gems = search_main(all_gems, github_page, full_name)
    all_gems = search_subjection(all_gems, github_dep)
    all_gems
  end

  def search_subjection(all_gems, page)
    all_gems[:used_by] = search_in_html(REQUEST_USED_BY, page)
    all_gems
  end
end
