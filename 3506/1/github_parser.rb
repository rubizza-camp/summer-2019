require 'nokogiri'
require 'open-uri'
require 'pry'

# Class for parsing information about gems on Github
# and putting all information into hash
class GithubParser
  attr_reader :github_link, :info

  def initialize(github_link)
    @info = {}
    @github_link = github_link
  end

  def parse
    parse_watches_stars_forks
    parse_issues
    parse_contributors
    parse_dependents_page
    info
  end

  private

  def label_to_i(label)
    label.text.tr(',', '').to_i
  end

  def parse_watches_stars_forks
    github_show_page.css('.pagehead-actions a.social-count').each do |tag_a|
      case tag_a['aria-label']
      when /watching/
        info[:watches] = label_to_i(tag_a)
      when /starred/
        info[:stars] = label_to_i(tag_a)
      when /forked/
        info[:forks] = label_to_i(tag_a)
      end
    end
  end

  def parse_issues
    issue = github_show_page.css("a[data-selected-links*='repo_issues'] span.Counter")
    info[:issues] = label_to_i(issue)
  end

  def parse_contributors
    contributor = github_show_page.css("a[href*='contributors'] span.num")
    info[:contributors] = label_to_i(contributor)
  end

  def parse_dependents_page
    info[:used_by] = label_to_i(github_dependents_page.css('a.btn-link')[0])
  end

  def github_show_page
    @github_show_page ||= begin
      Nokogiri::HTML(URI.open(github_link))
    rescue OpenURI::HTTPError
      puts "Page #{github_link} not found"
    end
  end

  def github_dependents_page
    dependents_url = "#{github_link}/network/dependents"
    @github_dependents_page ||= begin
      Nokogiri::HTML(URI.open(dependents_url))
    rescue OpenURI::HTTPError
      puts "Page #{dependents_url} not found"
    end
  end
end
