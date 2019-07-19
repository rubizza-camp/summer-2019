require 'terminal-table'

# Printing table with gems
class TableOutput
  HEADING_TABLE = ['name', 'used by', 'watchers', 'stars', 'forks', 'contributors', 'issues'].freeze

  def initialize(gems)
    @gems = gems
  end

  def execute
    print_gems
  end

  private

  def print_gems
    table_str = @gems.map do |gemi|
      create_string_table(gemi)
    end
    print_table(table_str)
  end

  def create_string_table(gemi)
    [
      gemi.gem_name, gemi.params[:used_by],
      gemi.params[:watchers], gemi.params[:stars],
      gemi.params[:forks], gemi.params[:contributors],
      gemi.params[:issues]
    ]
  end

  def print_table(tb_data)
    table = Terminal::Table.new headings: HEADING_TABLE, rows: tb_data
    puts table
  end
end
