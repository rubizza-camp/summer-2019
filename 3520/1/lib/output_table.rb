require 'tty-table'
require './lib/data_converter'

HEADER = ['name', 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues'].freeze

class OutputTable
  def initialize
    @table = TTY::Table.new header: HEADER
  end

  def full_table(data)
    data.each { |dat| add_value(dat) }
    puts show_table
  end

  def add_value(value)
    @table << DataConverter.convert_info_order(value)
  end

  def show_table
    @table.render :ascii, alignment: [:center], width: 80, resize: true do |renderer|
      renderer.border.separator = :each_row
    end
  end
end
