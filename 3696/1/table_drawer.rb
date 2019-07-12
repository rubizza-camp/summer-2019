require './scraper'
require 'terminal-table'
class TableDrawer
  def initialize(hash, top)
    @info_hash = hash
    @top = top
  end

  def draw
    puts Terminal::Table.new headings: ['Name', 'Watches', 'Stars', 'Forks', 'Contributors',
                                        'Issues', 'Used by'], rows: rows
  end

  private

  attr_reader :info_hash, :top

  def rows
    info_hash_local = append_names_transform
    table_rows = info_hash_local.values.sort_by { |value| -popularity(value) }
    return table_rows.take(top) unless top.zero?

    table_rows
  end

  def append_names_transform
    Hash[info_hash.collect { |key, value| [key, value.unshift(key)] }]
  end

  def popularity(info)
    Config::WEIGHTS.zip(info[1..-1]).inject(0) { |sum, (weight, value)| sum + (weight * value) }
  end
end
