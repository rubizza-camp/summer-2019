class StatisticPresenter
  def initialize(array_of_gems)
    @array_of_gems = array_of_gems
    @table = Terminal::Table.new
    @rows = []
  end

  def show_gems_statistics(top_number, name)
    build_table(top_number, name)
    puts "Top gems with word '#{name}' in it:" unless name.empty?
    puts "Top #{top_number} gems:" if name.empty?
    puts @table
  end

  private

  def build_table(top_number, name)
    head
    rows(name)
    @table.rows = @rows[0...top_number]
  end

  def head
    head = ["Gem\nname"]
    head += ['used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
    @table.headings = head
  end

  def stats_values_to_arr(gem)
    gem.stats.values
  end

  def rows(name)
    @array_of_gems.each do |gem|
      next unless gem.gem_name.include? name
      @rows << [gem.gem_name] + stats_values_to_arr(gem)
    end
  end
end
