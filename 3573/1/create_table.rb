require 'terminal-table'
class PrintTable
  HEADERS = %w[gem_name used_by watches stars forks contributors issues].freeze

  #:reek:FeatureEnvy
  def show_table(obj)
    table = Terminal::Table.new do |tab|
      tab.headings = HEADERS
      tab.rows = obj
    end
    puts table
  end
end
