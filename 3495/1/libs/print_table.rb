# This class print all gems with params
class TablePrinter
  def initialize(gems, count = 0)
    @count = count.to_i
    @gems = gems
  end

  def output_info
    gem_params_str = []
    @gems.map do |gem|
      gem_params_str << gem.insert_params
    end
    print_table(gem_params_str)
  end

  def print_table(gem_params_str)
    sotred_gems = gem_params_str.sort_by { |first| first[7] }.reverse!
    table = if @count != 0
              Terminal::Table.new headings: %w(gem watch stars forks issues contributors used_by
                                               gem_coolness), rows: sotred_gems.first(@count)
            else
              Terminal::Table.new headings: %w(gem watch stars forks issues contributors used_by
                                               gem_coolness), rows: sotred_gems
            end
    puts table
  end
end
