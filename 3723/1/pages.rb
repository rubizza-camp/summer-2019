require_relative 'repo'
require_relative 'taker'
require 'terminal-table'
require 'nokogiri'
require 'open-uri'

class Pages
  include Taker
  attr_reader :htmls, :rows

  def initialize
    @htmls = {}
    @rows = []
  end

  def sort_by_number(number)
    @rows = @rows.first(number) if number.positive?
  end

  def sort_by_name(name)
    @rows.map do |row|
      if row.first.include?(name)
        @rows = []
        @rows << row
      end
    end
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
