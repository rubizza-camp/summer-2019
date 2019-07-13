# rubocop:disable Lint/MissingCopEnableDirective, Style/GuardClause

require_relative './lib/repo_body.rb'
require_relative './lib/gem_sort.rb'
require_relative './lib/output.rb'
require_relative './lib/gem_entity.rb'
require 'yaml'
require 'json'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'terminal-table'
require 'faraday'

options = {}

OptionParser.new do |opts|
  opts.banner = 'Usage: top_gems.rb [options]'

  opts.on('-t', '--top=COUNT', Integer, 'shows the number of gems') do |top|
    options[:top] = top
  end

  opts.on('-n', '--name=TEXT', String, 'shows the gems that have the typed text') do |name|
    options[:name] = name
  end

  opts.on('-f', '--file=PATH', String, 'the path to the gem file') do |path|
    options[:file] = path
  end
end.parse!

class TopGems
  def initialize(options)
    @file = options[:file]
    @options = options
  end

  def call
    output = Output.new(@options)
    gem_list = parse_yaml
    sorted_gems = check_and_sort_gems(gem_list)
    output.gems(sorted_gems)
  end

  private

  def parse_yaml
    begin
      return YAML.load_file(@file)['gems'] if @file
    rescue TypeError
      puts 'file is not found, use default file...'
    end

    gem_names = YAML.load_file('gem_list.yml')['gems']
    gem_names.uniq
    check_gem_count(gem_names)
    gem_names
  end

  def check_gem_count(gems)
    if gems.count >= 15
      system('clear')
      puts 'too much gems, limit is 9'
      abort
    end
  end

  def check_and_sort_gems(gem_list)
    gems = gem_list.map do |gem_name|
      gem = RepoBody.new(gem_name)
      puts gem
      GemEntity.new(gem.name, gem.doc, gem.used_by_doc)
    end

    GemSort.new(gems).call
  end
end

TopGems.new(options).call
