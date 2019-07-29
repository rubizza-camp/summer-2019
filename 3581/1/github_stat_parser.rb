require 'nokogiri'
require 'open-uri'
require_relative 'github_html_parser.rb'

class GithubStatParser
  class << self
    def perform(url)
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      get_stats_from_html(doc, url)
    end

    private

    def get_stats_from_html(doc, url)
      used_by = get_used_by(url)
      arr_watch_star_fork = get_watch_star_fork(doc)
      issues = doc.css('.hx_reponav span a .Counter')[0].text.strip.to_i
      contrib = doc.css('.numbers-summary li')[3].css('a span').text.strip.to_i
      GithubHtmlParser.perform(arr_watch_star_fork, contrib, issues, used_by)
    end

    def get_watch_star_fork(doc)
      arr_watch_star_fork = []
      doc.css('.pagehead-actions li').each do |li|
        unless li.css('a').empty?
          data = li.css('a')[1]
          arr_watch_star_fork << data
        end
      end
    end

    def get_used_by(url)
      url << '/network/dependents'
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      used_by = doc.css('a.btn-link')[0].text.strip.delete("\n Repositories")
      used_by.sub!(',', '_').to_i
    end
  end
end
