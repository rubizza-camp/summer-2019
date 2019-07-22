require 'terminal-table'

# create table based on terminal-table gem
class GemsView
  HEAD_TEXT = %w[
    GEM_NAME
    USED_BY
    WATCH
    STARS
    FORKS
    CONTRIBUTORS
    ISSUES
    POPULARITY
  ].freeze

  def initialize(gems)
    @gems = gems
  end

  def render(top_n:)
    table_to_view = Terminal::Table.new(headings: HEAD_TEXT, rows: table_info(top_n))
    puts table_to_view
  end

  private

  def table_info(top_n)
    @table_info ||= @gems.sort.first(top_n).map(&method(:gem_to_row))
  end

  def gem_to_row(gem_info)
    [
      gem_info.name,
      gem_info.used_by,
      gem_info.watcher_count,
      gem_info.stars_count,
      gem_info.forks_count,
      gem_info.contributors_count,
      gem_info.issues_count,
      gem_info.rank
    ]
  end
end
