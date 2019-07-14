require 'terminal-table'
require 'json'
require 'yaml'
require 'faraday'
require 'nokogiri'
require 'open-uri'
require_relative './repo_list'
require_relative './taker'

class Pages
  include Taker
  attr_reader :htmls, :rows

  def initialize
    @htmls = {}
    @rows = []
  end

  def represent_info
    puts Terminal::Table.new rows: rows
  end

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
      rest.css('a')[43]['href'].split('/').last,
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
