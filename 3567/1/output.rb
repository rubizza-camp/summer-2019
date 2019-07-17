require 'terminal-table'

class Output
  DATA_STOCK = %i[repos Watch Star Fork Issues Used_by Contributors].freeze
  attr_reader :gemstorage

  def initialize(gemstorage:)
    @gemstorage = gemstorage
  end

  def create_table
    rows = gemstorage.each_with_object([]) { |gem, stock| stock << gem.values_at(*DATA_STOCK) }
    puts Terminal::Table.new headings: DATA_STOCK, rows: rows unless gemstorage.empty?
  end

  private

  def create_rows(key, meaning)
    rows = []
    rows.push(key)
    meaning.each { |_key, value| rows.push(value) }
    rows
  end
end
