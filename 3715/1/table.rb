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

  def self.table_row(ruby_gem)
    [
      ruby_gem.name,
      "used by #{ruby_gem.used_by}",
      "watched by #{ruby_gem.watch}",
      "#{ruby_gem.star} stars",
      "#{ruby_gem.fork} forks",
      "#{ruby_gem.contributors} contributors",
      "#{ruby_gem.issues} issues"
    ]
  end
end

def show_top(top)
  new_table = CreateTable.table(top)
  puts Terminal::Table.new(new_table)
end
