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
    page = Nokogiri::HTML(URI.open(github_link))
    combine_parsing(page)
    info
  end

  private

  def label_to_i(label)
    label.text.tr(',', '').to_i
  end

  def combine_parsing(page)
    parse_watches_stars_forks(page)
    parse_issues(page)
    parse_contributors(page)
    parse_dependents_page
  end

  def parse_watches_stars_forks(page)
    page.css('.pagehead-actions a.social-count').each do |tag_a|
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

  def parse_issues(page)
    issue = page.css("a[data-selected-links*='repo_issues'] span.Counter")
    info[:issues] = label_to_i(issue)
  end

  def parse_contributors(page)
    contributor = page.css("a[href*='contributors'] span.num")
    info[:contributors] = label_to_i(contributor)
  end

  def parse_dependents_page
    dependents_url = "#{github_link}/network/dependents"
    page = Nokogiri::HTML(URI.open(dependents_url))
    info[:used_by] = label_to_i(page.css('a.btn-link')[0])
    info
  rescue OpenURI::HTTPError
    puts "Github page #{dependents_url} not found"
  end
end
