require 'terminal-table'
require_relative 'gem_stat'

HEADERS = %w[Name Used\ by Watched\ by Stars Forks Contributors Issues].freeze

class Output
  def initialize(options)
    @options = options
  end

  def print_table
    rows = []
    select_top_gems.each { |gem| rows << gem.values }
    puts Terminal::Table.new headings: HEADERS, rows: rows
  end

  private

  def open_yaml
    @open_yaml = if @options[:file_name]
                   YAML.load_file(@options[:file_name].to_s)['gems']
                 else
                   YAML.load_file('gems.yml')['gems']
                 end
  end

  def select_gem_names
    if @options[:word]
      open_yaml.select { |name| name.include? @options[:word] }
    else
      open_yaml
    end
  end

  def select_top_gems
    if @options[:number]
      gem_stats_obj[0...@options[:number].to_i]
    else
      gem_stats_obj
    end
  end

  def gem_stats_obj
    gems = select_gem_names.map do |name|
      GemStatistic.new(name)
    end
    gems.map(&:create_stat).sort_by { |obj| obj['used_by'] }
  end
end
