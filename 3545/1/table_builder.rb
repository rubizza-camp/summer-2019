require 'terminal-table'

class TableBuilder
  def initialize(content)
    @content = content
  end

  def build_table
    rows = @content
    headings = ['Gem', 'Points', 'Stars', 'Watchers', 'Forks', 'Contributors', 'Issues', 'Used by']
    @table = Terminal::Table.new headings: headings, title: "Top #{rows.length} gem(s)", rows: rows
  end
end
