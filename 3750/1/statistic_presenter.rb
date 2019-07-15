require 'terminal-table'

class StatisticPresenter
  attr_reader :array_of_gems

  def initialize(array_of_gems)
    @array_of_gems = array_of_gems
    @table = Terminal::Table.new
    @rows = []
  end

  def form_table(top_number = array_of_gems.size, name = '')
    head
    rows(top_number, name)
    @table.rows = @rows
  end

  def show_gems_statistics(top_number = array_of_gems.size, name = '')
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
  end

  def rows(top_number, name)
    top_number.times do |count|
      next unless array_of_gems[count].gem_name.include? name
      @rows[count] = [array_of_gems[count].gem_name]
      @rows[count] += stats_to_arr(array_of_gems[count])
    end
  end
end
