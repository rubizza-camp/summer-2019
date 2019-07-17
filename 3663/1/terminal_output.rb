# This class helps to output all gems data in the table

require 'terminal-table'

class TerminalOutput
  attr_reader :output, :rows

  def generate_table(gems_data_array)
    @rows = gems_data_array.each_with_object([]) { |hash, array| array << collect(hash).flatten }
    @output = Terminal::Table.new rows: rows
  end

  private

  def collect(hash)
    hash.map do |gem_name, data_hash|
      [gem_name.to_s,
       "used by #{data_hash[:gem_used_by]}", "watched by #{data_hash[:gem_watched_by]}",
       "#{data_hash[:gem_stars]} stars", "#{data_hash[:gem_forks]} forks",
       "#{data_hash[:gem_contributors]} contributors", "#{data_hash[:gem_issues]} issues"]
    end
  end
end
