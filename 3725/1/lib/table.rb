require 'terminal-table'

module Table

  class Printer

    def self.create(sorted_repos:)
      headings = ["name", "total score", "stars", "forks", "contributors", "watchers", "issues", "used_by"]
      rows = sorted_repos.map { |hash| hash.values }
      table = Terminal::Table.new(headings: headings, rows: rows)
    end

  end

end
