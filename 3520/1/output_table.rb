# require 'terminal-table'
require 'tty-table'

class OutPutTable
  def initialize
    @table = TTY::Table.new header: ['name', 'used_by', 'watchers', 'stars', 'forks', 'issues', 'contributors']
  end

  def add_value(value)
    @table << value
  end

  def show_table
    @table.render :ascii, alignments: [:center], width: 80, resize: true
  end
end
