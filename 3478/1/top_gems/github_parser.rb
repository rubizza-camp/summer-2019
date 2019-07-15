require 'octokit'
require 'open-uri'
require 'nokogiri'

class GitHubParser
  def initialize(token)
    @client = Octokit::Client.new(access_token: token)
    @gem = {}
  end

  def parse(name)
    top_search = search_via_api(name)
    @gem = {}
    fill_the_data_from_api(top_search)
    fill_the_data_from_html(top_search[:full_name])
    @gem
  end

  private

  def fill_the_data_from_api(top_search)
    @gem[:name]        = top_search[:name]
    @gem[:total_score] = top_search[:score]
    @gem[:stars]       = top_search[:watchers_count]
    @gem[:forks]       = top_search[:forks]
  end

  def search_via_api(name)
    search_result = @client.search_repositories(name)
    search_result.items.first
  end

  def fill_the_data_from_html(full_name)
    search_main(Nokogiri::HTML(open("https://github.com/#{full_name}")), full_name)
    search_dependency(Nokogiri::HTML(open("https://github.com/#{full_name}/network/dependents")))
  end

  def search_dependency(page)
    @gem[:used_by]      = search_in_page('a[class=\'btn-link selected\']', page)
  end

  def search_main(page, full_name)
    @gem[:contributors] = search_in_page('a span[class=\'num text-emphasized\']', page)
    @gem[:watchers]     = search_in_page("li a[href=\"/#{full_name}/watchers\"]", page)
    @gem[:issues]       = search_in_page("span a[href=\"/#{full_name}/issues\"]", page)
  end

  def search_in_page(request, page)
    raw_text = page.search(request).text
    match = raw_text.match(/(\d+)((,\d+)?)*/)
    match[0].delete(',').to_i unless match.to_s.empty?
  end
end
