require_relative 'parse_gem_stats.rb'
require 'terminal-table'

module Table
  HEADING_TABLE = ['name', 'used by', 'watcheds', 'stars', 'forks', 'contributors', 'issues'].freeze
  STYLES_FOR_TABLE = {
    border_top: true, border_bottom: true, border_x: '<', border_i: '>'
  }.freeze

  private

  def create_string_table(repo)
    [
      repo[:name], repo[:used_by],
      repo[:watched_by], repo[:stars],
      repo[:forks], repo[:contributors],
      repo[:issues]
    ]
  end

  def print_table(str_table)
    table = Terminal::Table.new headings: HEADING_TABLE, rows: str_table, style: STYLES_FOR_TABLE
    puts table
  end
end
