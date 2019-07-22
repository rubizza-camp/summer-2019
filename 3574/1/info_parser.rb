require 'nokogiri'
require 'httparty'
require 'open-uri'

class InfoParser
  def take_information(names)
    names.map do |name_id|
      link = HTTParty.get("https://api.github.com/search/repositories?q=#{name_id}")
      github_api = link['items'].first
      values_for_gems(github_api, name_id)
    end
  end

  private

  def parse_used_by(github_api)
    nokogiri = Nokogiri::HTML(URI.open("#{github_api['html_url']}/network/dependents"))
    parse_element = nokogiri.css('div.table-list-header-toggle > a.btn-link')
    parse_element.first.text.delete(',').to_i
  end

  def parse_watch(github_api)
    nokogiri = Nokogiri::HTML(URI.open(github_api['html_url']))
    parse_element = nokogiri.css('ul.pagehead-actions > li > a.social-count')
    parse_element.first.text.delete(',').to_i
  end

  def parse_contributors(github_api)
    nokogiri = Nokogiri::HTML(URI.open(github_api['html_url']))
    parse_element = nokogiri.css('ul.numbers-summary > li > a > span.num')
    parse_element.last.text.delete(',').to_i
  end

  def values_for_gems(github_api, name_id)
    {
      name_id:  name_id,
      used_by: parse_used_by(github_api),
      watch: parse_watch(github_api),
      stars: github_api['stargazers_count'],
      fork: github_api['forks'],
      issues: github_api['open_issues_count'],
      contributors:  parse_contributors(github_api)
    }
  end
end
