require 'yaml'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require './presenter'
require './scraper'
require './name_to_link_transformer.rb'

class TopGems
  def ranking(file, name)
    @ranking ||= file.each_with_object({}) do |str, hsh|
      next unless str.start_with? name

      @transformer = NameToLinkTransformer.new(str)

      hsh[str] = Scraper.new(@transformer.link) if @transformer.valid
    end
  end

  def run
    file, name, top = options
    ranking(file, name)
    Presenter.new(@ranking, top)
  end

  def parse
    @parser.parse!(into: @options)
  end

  def options
    file = @options[:file] || 'example.yaml'
    name = @options[:name] || ''
    top = @options[:top].to_i
    file = YAML.load_file(file)['gems']
    [file, name, top]
  end

  def initialize
    @options = {}
    @parser = OptionParser.new do |opt|
      opt.on('--top TOP')
      opt.on('--name NAME')
      opt.on('--file FILE')
    end
    @ranking = nil
    parse
    run
  end
end
TopGems.new
