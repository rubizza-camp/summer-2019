require 'open-uri'
# Class for parsing github url of gem
class DataParser
  def initialize(parsed_html, github_url)
    @parsed_html = parsed_html
    @github_url = github_url
  end

  def only_stats
    [take_used_by, take_watched_by, take_stars, take_forks, take_contributors, take_issues]
  end

  private

  def take_used_by
    parsed_html = Nokogiri::HTML(URI.parse(@github_url + '/network/dependents').open)
    parsed_html.css('div.table-list-header-toggle a')[0].text.delete('^0-9').to_i
  end

  def take_watched_by
    @parsed_html.css('ul.pagehead-actions a')[1].text.delete('^0-9').to_i
  end

  def take_stars
    @parsed_html.css('ul.pagehead-actions a')[3].text.delete('^0-9').to_i
  end

  def take_forks
    @parsed_html.css('ul.pagehead-actions a')[5].text.delete('^0-9').to_i
  end

  def take_contributors
    parsed_html = Nokogiri::HTML(URI.parse(@github_url + '/contributors_size').open)
    parsed_html.css('span').text.delete('^0-9').to_i
  end

  def take_issues
    @parsed_html.css('nav.hx_reponav span')[4].text.to_i
  end
end
