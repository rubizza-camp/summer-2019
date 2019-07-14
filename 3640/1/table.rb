require 'terminal-table'
require_relative 'all_gems_fetcher.rb'
require_relative 'gem_terminal_output.rb'
require_relative 'parse_file_fetcher.rb'
# :reek:InstanceVariableAssumption
class Table
  def table_output(selector)
    rows = get_all_gems(selector).map { |gem| GemTerminalOutput.get_gem_terminal_output(gem) }
    puts Terminal::Table.new(rows: rows)
  end

  private

  def get_all_gems(selector)
    names_all_gems = ParseFileFetcher.get_all_names('gems.yaml')
    @all_gems = AllGemsFetcher.all_gems_get(names_all_gems).sort_by(&:rating).reverse
    return @all_gems if selector.empty?
    get_requested_gems(selector)
  end

  def get_requested_gems(tag)
    tag.key?(:top) ? amount_gems(@all_gems, tag[:top]) : gems_by_name(@all_gems, tag[:name])
  end

  def amount_gems(all_gems, amount)
    all_gems.first(amount)
  end

  def gems_by_name(all_gems, name)
    all_gems.select { |gem| gem.name.include?(name) ? gem : next }
  end
end
