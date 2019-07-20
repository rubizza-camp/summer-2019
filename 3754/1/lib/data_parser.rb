require 'open-uri'
# Class for parsing github url of gem
class DataParser
  attr_reader :parsed_html, :data

  def initialize
    @parsed_html = ''
    @data = []
  end

  def self.collect_data(github_urls_list)
    new.collect_data(github_urls_list)
  end

  def collect_data(github_urls_list)
    github_urls_list.each do |gem_name, github_url|
      @parsed_html = Nokogiri::HTML(URI.parse(github_url).open)
      data << [gem_name,
               take_used_by(github_url), take_watched_by,
               take_stars, take_forks,
               take_contributors(github_url), take_issues]
    end
    data
  end

  private

  def take_used_by(github_url)
    parsed_html = Nokogiri::HTML(URI.parse(github_url + '/network/dependents').open)
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

  def take_contributors(github_url)
    parsed_html = Nokogiri::HTML(URI.parse(github_url + '/contributors_size').open)
    parsed_html.css('span').text.delete('^0-9').to_i
  end

  def take_issues
    @parsed_html.css('nav.hx_reponav span')[4].text.to_i
  end
end
