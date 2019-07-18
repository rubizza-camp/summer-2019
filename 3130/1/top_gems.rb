require 'yaml'
require_relative 'gem_info'
require_relative 'gems_table'

class TopGems
  FILE_PATH = 'config.yml'.freeze

  def initialize(args = [])
    @hash_args = parse_args(args)
    @gem_names, @weights = []
  end

  def call
    parse_file
    GemsTable.new(gems_to_display).call
  end

  private

  def gems_to_display
    gems = sort_gems(gem_data)
    gems.take(@hash_args[:top].to_i) if @hash_args[:top]
    gems
  end

  def gem_data
    @gem_names.map { |gem_name| GemInfo.new(gem_name, @weights || {}).call }
  end

  def file_to_hash
    file_path = @hash_args.include?(:file) ? @hash_args[:file] : FILE_PATH
    YAML.load_file(file_path)
  end

  def parse_file
    file_hash = file_to_hash
    @gem_names = file_hash['gems'].select { |el| el.include?(@hash_args[:name].to_s) }
    return unless file_hash['score_params']
    @weights = file_hash['score_params'].transform_keys(&:to_sym)
  end

  def parse_args(args)
    args.reduce({}) do |acc, arg|
      key, value = arg.scan(/--(\w+)=([^ ]+)/).flatten
      acc.merge!(key.to_sym => value)
    end
  end

  def sort_gems(gems)
    gems.sort_by do |gem|
      -gem[:score]
    end
  end
end

puts TopGems.new(ARGV).call
