require 'yaml'
require 'open-uri'
require 'optparse'
require './table_drawer'
require './scraper'
require './name_to_link_transformer.rb'

class TopGems
  def initialize
    @options = parse
  end

  def run
    TableDrawer.new(ranking(gem_names, name_pattern), top).draw
  end

  private

  attr_reader :options

  def ranking(file, name)
    file.each_with_object({}) do |str, hsh|
      next unless str.start_with? name

      transformer_link = NameToLinkTransformer.new(str).link
      hsh[str] = scrape_value(transformer_link) unless transformer_link == 'no-link'
    end
  end

  def gem_names
    @gem_names ||= begin
      path = options[:file] || 'example.yaml'
      YAML.load_file(path)['gems']
    end
  end

  def name_pattern
    @name_pattern ||= @options[:name] || ''
  end

  def top
    @top ||= @options[:top].to_i
  end

  def scrape_value(link)
    scraper = Scraper.new(link)
    info = scraper.scrape
    scraper.close
    info
  end

  def create_parser
    OptionParser.new do |opt|
      opt.on('--top TOP')
      opt.on('--name NAME')
      opt.on('--file FILE')
    end
  end

  def parse
    options = {}
    create_parser.parse!(into: options)
    options
  end
end
TopGems.new.run
