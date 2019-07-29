require 'terminal-table'

class TableCreator
  TABLE_STYLE = { border_top: false, border_bottom: false }.freeze

  def self.call(array_gems_score, row_count)
    table = Terminal::Table.new(style: TABLE_STYLE)
    add_rows(table, row_count, array_gems_score)
    puts table
  end

  def self.add_rows(table, row_count, array_gems_score)
    row_count.times do |index|
      table.add_row(GemSerializer.call(array_gems_score[index]))
    end
  end
end
