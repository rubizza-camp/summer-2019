require 'terminal-table'
require_relative 'gemy'

class StatisticPresenter
  def initialize(array_of_gems)
    @array_of_gems = array_of_gems
    @table = Terminal::Table.new
    @rows = []
  end

  def form_table(top_number, name)
    head
    rows(name)
    @table.rows = @rows[0..(top_number - 1)]
  end

  def show_gems_statistics(top_number, name)
    form_table(top_number, name)
    puts "Top gems with word '#{name}' in it:" unless name.empty?
    puts "Top #{top_number} gems:" if name.empty?
    puts @table
  end

  private

  def head
    head = ["Gem\nname"]
    head += ['used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
    @table.headings = head
  end

  def stats_to_arr(gem)
    array_of_stats = []
    gem.stats.each_value { |value| array_of_stats << value }
    array_of_stats
  end

  def rows(name)
    @array_of_gems.each do |gem|
      next unless gem.gem_name.include? name
      @rows << [gem.gem_name] + stats_to_arr(gem)
    end
  end
end
