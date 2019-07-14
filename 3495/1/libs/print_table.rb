# This class print all gems with params
#:reek:InstanceVariableAssumption:
#:reek:FeatureEnvy:
class TablePrinter
  attr_reader :gem_params_str
  def initialize(gems)
    @gems = gems
  end

  def output_info
    @gem_params_str = []
    @gems.map do |gem|
      @gem_params_str << [gem.gem_name, gem.watch, gem.stars, gem.forks,
                          gem.issues, gem.contributors, gem.used_by, gem.coolness]
    end
    print_table
  end

  def print_table
    @gem_params_str.sort! { |first, second| first[7] <=> second[7] }.reverse!
    table = Terminal::Table.new headings: ['gem', 'watch', 'stars', 'forks', 'issues', 'contributors', 'used by',
                                           'gem coolness'], rows: @gem_params_str
    puts table
  end
end
