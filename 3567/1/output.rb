require 'terminal-table'

class Output
  ARR_OF_HEADERS = %w[repos Watch Star Fork Issues Used_by Contributors].freeze
  ARR_OF_SYMBOLS = %i[repos Watch Star Fork Issues Used_by Contributors].freeze
  attr_reader :gemstorage

  def initialize(gemstorage:)
    @gemstorage = gemstorage
  end

  def create_table
    rows = []
    gemstorage.each { |gem| rows << gem.values_at(*ARR_OF_SYMBOLS) }
    puts Terminal::Table.new headings: ARR_OF_HEADERS, rows: rows unless gemstorage.empty?
  end

  private

  def create_rows(key, meaning)
    rows = []
    rows.push(key)
    meaning.each { |_key, value| rows.push(value) }
    rows
  end
end
