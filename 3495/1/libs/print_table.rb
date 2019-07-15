# This class print all gems with params
# :reek:FeatureEnvy
# :reek:InstanceVariableAssumption
class TablePrinter
  attr_reader :gem_params_str

  def initialize(gems, count = 0)
    @count = count.to_i
    @gems = gems
  end

  def output_info
    @gem_params_str = []
    @gems.map do |gem|
      @gem_params_str << [gem.gem_name, gem.watch, gem.stars, gem.forks,
                          gem.issues, gem.contributors, gem.used_by, gem.coolness]
    end
    sort_gems
    print_table
  end

  def sort_gems
    @gem_params_str.sort! { |first, second| first[7] <=> second[7] }.reverse!
  end

  def print_table
    table = if @count != 0
              Terminal::Table.new headings: %w(gem watch stars forks issues contributors used_by
                                               gem_coolness), rows: @gem_params_str.first(@count)
            else
              Terminal::Table.new headings: %w(gem watch stars forks issues contributors used_by
                                               gem_coolness), rows: @gem_params_str
            end
    puts table
  end
end
