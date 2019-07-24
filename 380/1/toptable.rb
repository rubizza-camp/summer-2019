require 'pry'
require 'terminal-table'

# shows top of gems by popularity
class TopTable
  def initialize(gem_list, count)
    @gem_list = gem_list
    @table = Terminal::Table.new do |table|
      table.headings = [
        'Gem', 'Used By', 'Watched By', 'Stars', 'Forks', 'Contributors', 'Issues'
      ]
      load_rows_in(table, count)
    end
  end

  def show
    puts @table
  end

  private

  def load_rows_in(table, count = nil)
    final_list = count ? sorted_gems.first(count) : sorted_gems
    final_list.each do |gem|
      table << gem.values_at(:name, :used_by, :subscribers, :stargazers, :forks_count,
                             :contributors, :issues)
    end
  end

  def sorted_gems
    add_popularity
    @gem_list.sort_by { |gem| gem[:popularity] }.reverse!
  end

  # :reek:FeatureEnvy:
  def add_popularity
    @gem_list.map do |gem|
      gem[:popularity] = [gem[:stargazers],
                          gem[:forks_count],
                          gem[:issues],
                          gem[:subscribers],
                          gem[:contributors],
                          gem[:used_by]].inject(:+)
    end
  end
end
