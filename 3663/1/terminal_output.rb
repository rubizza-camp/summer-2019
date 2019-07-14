# This class helps to output all gems data in the table
require 'terminal-table'

class TerminalOutput
  attr_reader :output

  def initialize(gems_data_array)
    generate_table(gems_data_array)
  end

  protected

  def generate_table(gems_data_array)
    table_rows = []
    gems_data_array.each do |hash|
      hash.each do |gem_name, data_hash|
        table_rows << [gem_name.to_s,
                       "used by #{data_hash[:gem_used_by]}",
                       "watched by #{data_hash[:gem_watched_by]}",
                       "#{data_hash[:gem_stars]} stars",
                       "#{data_hash[:gem_forks]} forks",
                       "#{data_hash[:gem_contributors]} contributors",
                       "#{data_hash[:gem_issues]} issues"]
      end
    end
    @output = Terminal::Table.new rows: table_rows
  end
end
