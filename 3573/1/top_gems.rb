require 'yaml'
require_relative 'parser'
require 'terminal-table'

def gem_names
  YAML.load_file('ruby_gems.yaml')['gems']
end

def statistic_rows
  parsers = gem_names.map do |name|
    Parser.new(gem_name: name)
  end
  parsers.map { |parser| parser.create_statistic.strings }
end

def show_statistic
  rows = []
  statistic_rows.each { |value| rows << value }
  table = Terminal::Table.new do |tab|
    tab.rows = rows
    tab.style = { border_top: false, border_bottom: false }
  end
  puts table
end
show_statistic
