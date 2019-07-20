require 'terminal-table'

# :reek:NestedIterators:
# shows top of gems by popularity
class TopTable
  def initialize(gem_list, count)
    @table = Terminal::Table.new do |table|
      table.headings = [
        'Gem', 'Used By', 'Watched By', 'Stars', 'Forks', 'Contributors', 'Issues'
      ]
      sorted_gems(gem_list, count).each do |gem|
        table << result(gem)
      end
    end
  end

  def show
    puts @table
  end

  private

  # :reek:UtilityFunction
  def result(gem)
    gem.values_at(
      :name,
      :used_by,
      :subscribers,
      :stargazers,
      :forks_count,
      :contributors,
      :issues
    )
  end

  # :reek:UtilityFunction
  def add_popularity(gem_list)
    gem_list.each do |gem|
      gem[:popularity] = [gem[:stargazers],
                          gem[:forks_count],
                          gem[:issues],
                          gem[:subscribers],
                          gem[:contributors],
                          gem[:used_by]].inject(:+)
    end
  end

  # :reek:FeatureEnvy:, :reek:TooManyStatements
  def sorted_gems(result, count = nil)
    pop_result = add_popularity(result)
    result_array = pop_result.sort_by { |gem| gem[:popularity] }
    result_array.reverse!
    result_array = result_array.first(count) if count
    result_array
  end
end
