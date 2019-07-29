require_relative 'repo_info_loader'
require_relative 'html_parser'
require 'terminal-table'
require 'nokogiri'
require 'open-uri'

class SortedPages
  include HtmlParser
  attr_reader :htmls, :rows

  def initialize
    @htmls = {}
    @rows = []
  end

  def call(list)
    save_htmls(list)
    take_content(@htmls)
  end

  private

  def rating
    @rows.sort_by! { |row| score(row) }.reverse!
  end

  def save_htmls(list)
    list.map do |repo|
      doc = Nokogiri::HTML.parse(URI.open("#{repo}/network/dependents"))
      rest = Nokogiri::HTML.parse(URI.open(repo))
      @htmls[rest] = doc
    end
  end

  def rowing(rest, doc)
    rows << [
      names(rest),
      "used by #{depen(doc)}",
      "watched by #{watch(rest)}",
      "stars #{star(rest)}",
      "forks #{forks(rest)}",
      "contributors #{contributors(rest)}",
      "issues #{issues(rest)}"
    ]
  end

  def take_content(htmls)
    htmls.each do |rest, doc|
      rowing(rest, doc)
    end
    rating
  end
end
