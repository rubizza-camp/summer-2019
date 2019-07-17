require_relative 'gemlist.rb'
require 'terminal-table'

# Configuration of the table with the results
class CreateTable
  HEADER = [
    'Title gem',
    'Depend on',
    'Are watching',
    'Has stars',
    'Has forks',
    'Has contributors',
    'Has issues'
  ].freeze

  def self.table(top_gems)
    {
      headings: HEADER,
      rows: top_gems.map(&method(:table_row)),
      style: { alignment: :center, all_separators: true }
    }
  end

  def self.table_row(gem)
    [
      gem.name,
      "used by #{gem.used_by}",
      "watched by #{gem.watch}",
      "#{gem.star} stars",
      "#{gem.fork} forks",
      "#{gem.contributors} contributors",
      "#{gem.issues} issues"
    ]
  end
end

def show_top(top)
  new_table = CreateTable.table(top)
  puts Terminal::Table.new(new_table)
end
