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
    rescue StandardError
      puts 'file not found, use default'
    end
    
    YAML.load_file('gem_list.yml')['gems']
  end

 

  def check_and_sort_gems(gem_list)
    gem_repos = gem_list.map { |gem_name| RepoBody.new(gem_name) }
    gems = gem_repos.map { |gem| GemEntity.new(gem.name, gem.doc, gem.used_by_doc) }
    GemSort.new(gems).call
  end
end

TopGems.new(options).call
