# require 'terminal-table'
require 'tty-table'

class OutputTable
  def initialize
    @table = TTY::Table.new header: ['name', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
  end

  def add_value(value)
    @table << value
  end

  def show_table
    @table.render :ascii, alignment: [:center], width: 80, resize: true
  end
end
