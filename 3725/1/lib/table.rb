require 'terminal-table'

module Table
  class Printer
    def self.create(sorted_repos:)
      headings = %w[name total_score stars forks contributors watchers issues used_by]
      rows = sorted_repos.map(&:values)
      Terminal::Table.new(headings: headings, rows: rows)
    end
  end
end
