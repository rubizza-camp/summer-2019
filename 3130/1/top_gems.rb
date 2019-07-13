require 'yaml'
require_relative 'gem_info'

class TopGems
  def initialize(args = [])
    @hash_args = parse_args(args)
    file_path = @hash_args.include?(:file) ? @hash_args[:file] : 'config.yml'
    @gem_names = YAML.load_file(file_path)['gems']
    @col_size = {}
    @gem_data = []
  end

  def call
    @gem_names.select! { |el| el.include?(@hash_args[:name].to_s) }
    @gem_data = GemInfo.new(@gem_names).call
    count_column_sizes
    generate_formatted_result
  end

  private

  def parse_args(args)
    hash_args = {}
    args.each do |arg|
      key, value = arg.scan(/--(\w+)=([^ ]+)/).flatten
      hash_args.merge!(
        key.to_sym => value
      )
    end
    hash_args
  end

  def count_size_for_column(key)
    @gem_data.map { |el| el[key].to_s.length }.max
  end

  def count_column_sizes
    @gem_data.first.keys.each do |key|
      @col_size[key] = count_size_for_column(key)
    end
  end

  def gem_statistic_value(gem_stats, key)
    gem_stats[key].to_s.ljust(@col_size[key]).to_s
  end

  def format_gem(gem_stats)
    "#{gem_statistic_value(gem_stats, :name)} |" \
      " used by #{gem_statistic_value(gem_stats, :used_by)} |" \
      " watched by #{gem_statistic_value(gem_stats, :watchers_count)} |" \
      " #{gem_statistic_value(gem_stats, :stargazers_count)} stars |" \
      " #{gem_statistic_value(gem_stats, :forks_count)} forks |" \
      " #{gem_statistic_value(gem_stats, :contributors)} contributors |" \
      " #{gem_statistic_value(gem_stats, :open_issues)} issues |"
  end

  def generate_formatted_result
    @gem_data = @gem_data.first(@hash_args[:top].to_i) if @hash_args[:top]
    formatted_result = []
    @gem_data.each do |gem_stats|
      formatted_result << format_gem(gem_stats)
    end
    formatted_result
  end
end

puts TopGems.new(ARGV).call
