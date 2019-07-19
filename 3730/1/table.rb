require 'terminal-table'

class Table
  HEADINGS = %w[Name Used\ by Watched\ by Star Forks Contributors Issues].freeze

  def self.add_row_to_table(gems, row, number)
    gems[0...number].each { |gem| row.add_row gem.output }
  end

  def self.print_table(gems, number)
    table = Terminal::Table.new do |row|
      add_row_to_table(gems, row, number)
    end

    table.title = 'Gems statistics'
    table.headings = HEADINGS
    puts table
  end

  private_class_method :add_row_to_table
end
