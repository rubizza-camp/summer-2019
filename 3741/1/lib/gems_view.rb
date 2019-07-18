require 'terminal-table'

# create table based on terminal-table gem
class GemsView
  def initialize(gems)
    @gems = gems
  end

  def render(top_n:)
    table_info = @gems.sort.first(top_n).map { |gem_info| gem_to_row(gem_info) }
    head_text = %w[Gem_name USED_BY WATCH STARS FORKS CONTRIBUTORS ISSUES POPULARITY]
    table_to_view = Terminal::Table.new(headings: head_text, rows: table_info)
    puts table_to_view
  end

  private

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
