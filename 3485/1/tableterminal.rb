require_relative 'findgem.rb'
require 'terminal-table'

module Table
  HEADING_TABLE = ['name', 'used by', 'watcheds', 'stars', 'forks', 'contributors', 'issues'].freeze
  STYLES_FOR_TABLE = {
    border_top: true, border_bottom: true, border_x: '<', border_i: '>'
  }.freeze

  private

  def create_string_table(repo)
    [
      repo.stats_from_git[:name], repo.stats_from_git[:used_by],
      repo.stats_from_git[:watched_by], repo.stats_from_git[:stars],
      repo.stats_from_git[:forks], repo.stats_from_git[:contributors],
      repo.stats_from_git[:issues]
    ]
  end

  def print_table(str_table)
    table = Terminal::Table.new headings: HEADING_TABLE, rows: str_table, style: STYLES_FOR_TABLE
    puts table
  end
end
