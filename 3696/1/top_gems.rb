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
    file, name, top = options.values_at(:file, :name, :top)
    TableDrawer.new(ranking(file, name), top).draw
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
    validate_options(options)
  end

  def validate_options(options_hash)
    options_hash[:file] ||= 'example.yaml'
    options_hash[:file] = YAML.load_file(options_hash[:file])['gems']
    options_hash[:name] ||= ''
    options_hash[:top] = options_hash[:top].to_i
    options_hash
  end
end
TopGems.new.run
