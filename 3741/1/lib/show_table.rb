require 'terminal-table'

# create table based on terminal-table gem
class GemsView
  def call(gems)
    table_info = gems.map { |gem_info| gem_to_row(gem_info) }
    table_to_view = Terminal::Table.new rows: table_info
    puts table_to_view
  end

  private

  def gem_to_row(gem_info)
    [
      gem_info.name,
      "used by #{gem_info.used_by}",
      "watched by #{gem_info.watcher_count}",
      "#{gem_info.stars_count} stars",
      "#{gem_info.forks_count} forks",
      "#{gem_info.contributors_count} contributors",
      "#{gem_info.issues_count} issues",
      "#{gem_info.rank} popularity"
    ]
  end
end
