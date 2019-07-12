require './scraper'
require 'terminal-table'
class Presenter
  def initialize(hash, top)
    @hash = hash
    @top = top
    @rows = []
    generate_rows
    table = Terminal::Table.new headings: ['Name', 'Watches', 'Stars', 'Forks', 'Contributors',
                                           'Issues', 'Used by'], rows: @rows
    puts table
  end

  def generate_rows
    @rows = sort_by_popularity.map { |key, value| value.row.unshift(key) }
    @rows = @rows.take(@top) unless @top.zero?
  end

  def sort_by_popularity
    @hash.sort_by { |_key, value| value.popularity }
  end
end
