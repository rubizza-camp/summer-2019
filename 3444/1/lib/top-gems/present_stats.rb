require 'terminal-table'
# This is service class for drawing tables, also here
# realized some logic, as sorting by count of output rows and
# feature by sorting of any of the columns.
# :reek:TooManyStatements
module TopGems
  class PresentStats
    def self.call(gems_stats, opts)
      new.draw(gems_stats, opts)
    end

    def draw(gems_stats, opts)
      sorted = gems_stats.sort_by { |hash| hash[:rate] }.reverse
      limit = sort_by_number(sorted, opts)
      for_table = limit.map { |value| format(value) }
      output_to_shell(for_table)
    end

    private

    def sort_by_number(gems_stats, options)
      if options[:number].to_s.empty?
        gems_stats
      else
        gems_stats.take(options[:number])
      end
    end

    def format(hash)
      [
        hash[:name].to_s,
        "used by #{hash[:used_by]}",
        "watched by #{hash[:watched_by]}",
        "#{hash[:stars]} stars",
        "#{hash[:forks]} forks",
        "#{hash[:contributors]} contributors",
        "#{hash[:issues]} issues"
      ]
    end

    def output_to_shell(arr)
      table = Terminal::Table.new(rows: arr)
      puts table
    end
  end
end
