require 'terminal-table'
require_relative 'all_gems_fetcher.rb'
require_relative 'gem_terminal_output.rb'
require 'yaml'

class Table
  def self.fetch_table_output(selector)
    fetcher = new
    fetcher.fetch_table_output(selector)
  end

  def fetch_table_output(param)
    rows = get_requested_gems(param).map { |gem| GemTerminalOutput.fetch_gem_terminal_output(gem) }
    puts Terminal::Table.new(rows: rows)
  end

  private

  def all_gems
    names_all_gems = YAML.load_file('gems.yaml')['gems']
    @all_gems ||= AllGemsFetcher.fetch_all_gems(names_all_gems).sort_by(&:rating).reverse
  end

  def get_requested_gems(selector)
    get_path_file(selector[:file]) if selector.key?(:file)
    return all_gems if selector.empty?
    gems_by_name = fetch_gems_by_name(all_gems, selector)
    if gems_by_name == []
      puts "The entered name doesn't match the gems in the file gems.yaml"
    else
      fetch_gems_by_amount(gems_by_name, selector)
    end
  end

  def fetch_gems_by_amount(all_gems, selector)
    selector.key?(:top) ? all_gems.first(selector[:top]) : all_gems
  end

  def fetch_gems_by_name(all_gems, selector)
    if selector.key?(:name) == true
      return all_gems.select { |gem| gem.name.include?(selector[:name]) ? gem : next }
    end
    all_gems
  end

  def get_path_file(file_name)
    if file_name == 'gems.yaml'
      puts "Path to directory of gems list is:\n" + Dir.pwd + "/#{file_name}"
    else
      puts 'Invalid file name entered'
    end
  end
end
