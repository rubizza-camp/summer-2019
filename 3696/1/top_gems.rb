require 'yaml'
require 'nokogiri'
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
    file, name, top = @options.values_at(:file, :name, :top)
    TableDrawer.new(ranking(file, name), top).draw
  end

  private

  def ranking(file, name)
    ranking = file.each_with_object({}) do |str, hsh|
      next unless str.start_with? name

      transformer = NameToLinkTransformer.new(str)
      hsh[str] = Scraper.new(transformer.link).scrape if transformer.link != 'no-link'
    end
    ranking
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
