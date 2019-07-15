require_relative './lib/repo_body.rb'
require_relative './lib/gem_sorter.rb'
require_relative './lib/output.rb'
require_relative './lib/gem_entity.rb'
require 'yaml'
require 'optparse'
require 'nokogiri'
require 'open-uri'

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

  opts.on('-v', '--verbose', 'Run verbosely') do |ver|
    options[:verbose] = ver
  end
end.parse!

class TopGems
  def run(options)
    @options = options
    @file = options[:file]

    output = Output.new(options[:name], options[:top])
    gem_list = parse_yaml
    sorted_gems = check_and_sort_gems(gem_list)
    output.gems(sorted_gems)
  end

  private

  def parse_yaml
    return load_custom if @file

    load_default
  end

  def load_default
    file = File.join(Dir.pwd, 'gem_list.yml')
    YAML.load_file(file)['gems'].uniq
  rescue Errno::ENOENT
    warn "file #{file} is not found, please use -f option"
    abort
  rescue NoMethodError
    warn 'no gems'
    abort
  end

  def load_custom
    file = File.expand_path('.', @file)
    YAML.load_file(file)['gems'].uniq
  rescue Errno::ENOENT
    warn "file #{file} is not found, using default file..."
    load_default
  rescue NoMethodError
    warn 'no gems'
    abort
  end

  def check_and_sort_gems(gem_list)
    gems = gem_list.map do |gem_name|
      gem = RepoBody.new(gem_name)
      gem.fetch_params

      gem_entity = GemEntity.new(gem_name, gem.doc, gem.used_by_doc, @options[:verbose])
      gem_entity.set_params
      gem_entity
    end

    GemSorter.new.call(gems)
  end
end

TopGems.new.run(options)
