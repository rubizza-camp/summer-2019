require 'terminal-table'

class TableMaker
  TABLE_HEADIN = ['gem name', 'used by', 'contributors', 'issues', 'stars', 'watch', 'forks'].freeze

  def initialize(gems_info)
    @info = gems_info
  end

  def make_table
    rows = []
    @info.select { |item| rows << item.values }
    Terminal::Table.new headings: TABLE_HEADIN, rows: rows
  end
end
