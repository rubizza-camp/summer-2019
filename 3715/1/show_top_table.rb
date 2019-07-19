require_relative 'gem_list.rb'
require 'terminal-table'

# Configuration of the table with the results
class ShowTopTable
  HEADER = [
    'Gem title',
    'Depend on',
    'Are watching',
    'Has stars',
    'Has forks',
    'Has contributors',
    'Has issues'
  ].freeze

  attr_reader :table_data, :top_gems

  def initialize(top_gems)
    @top_gems = top_gems
  end

  def call
    @table_data = prepare_table_data
    output_table
  end

  private

  def prepare_table_data
    {
      headings: HEADER,
      rows: top_gems.map(&method(:present_table_row)),
      style: { alignment: :center, all_separators: true }
    }
  end

  def output_table
    puts Terminal::Table.new(table_data)
  end

  def present_table_row(gem)
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
