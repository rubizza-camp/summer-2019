require 'terminal-table'

class TableMaker
  TABLE_HEADIN = %w[name used contributors issues stars watch forks].freeze

  def initialize(gems_info)
    @info = gems_info
  end

  def make
    rows = @info.map(&:values)
    Terminal::Table.new headings: TABLE_HEADIN, rows: rows
  end
end
