require_relative 'scraper.rb'
require 'terminal-table'
require 'yaml'

class Table
  def self.fetch_table_output(selector)
    fetcher = new(selector)
    fetcher.fetch_table_output
  end

  def initialize(selector)
    @selector = selector
    @gems_file_name = 'gems.yaml'
  end

  def fetch_table_output
    rows = fetch_requested_gems.map(&:to_row)
    puts Terminal::Table.new(rows: rows)
  end

  private

  def all_gems
    names_all_gems = YAML.load_file(@gems_file_name)['gems']
    @all_gems ||= Scraper.fetch_gem_parameters(names_all_gems).sort_by(&:rating).reverse
  end

  def fetch_requested_gems
    print_path_file(@selector[:file])
    return all_gems if @selector.empty?
    gems_by_name = fetch_gems_by_name
    if gems_by_name == []
      puts "The entered name doesn't match the gems in the file gems.yaml"
    else
      fetch_gems_by_amount(gems_by_name)
    end
  end

  def fetch_gems_by_amount(gems)
    return gems unless @selector.key?(:top)
    gems.first(@selector[:top])
  end

  def fetch_gems_by_name
    return all_gems unless @selector.key?(:name)
    all_gems.select { |gem| gem.name.include?(@selector[:name]) }
  end

  def print_path_file(file_name)
    return nil unless @selector.key?(:file)
    if File.exist?(file_name)
      puts "Path to directory of gems list is:\n#{Dir.pwd}/#{file_name}"
    else
      puts 'Entered file does not exist'
    end
  end
end
