require 'yaml'
require 'open-uri'
require 'optparse'
require './table_drawer'
require './scraper'
require './name_to_link_transformer.rb'
require 'i18n'
class Main
  def initialize
    @options = parse
  end

  def run
    I18n.load_path = Dir['./locales.yml']
    I18n.locale = YAML.load_file('default_locale.yaml')['locale'].to_sym

    TableDrawer.new(browser_session_scrape(gem_names, name_pattern), top).draw
  end

  private

  attr_reader :options

  def browser
    @browser ||= Watir::Browser.new(:firefox, headless: true)
  end

  def error_list
    @error_list ||= []
  end

  def browser_session_scrape(file, name_pattern)
    info = info_scrape(file, name_pattern)
    browser.close
    error_report(info, file)
    info
  end

  def error_report(info, file)
    print "#{info.size} #{I18n.t('out')} #{file.size} #{I18n.t('processed')}. #{I18n.t('fail')}:"
    error_list.empty? ? puts('none') : puts(error_list)
  end

  def info_scrape(file, name_pattern)
    file.each_with_object({}) do |str, hsh|
      next unless str.start_with?(name_pattern)

      transformer_link = NameToLinkTransformer.new(str).link
      transformer_link == 'no-link' ? error_list << str : hsh[str] = scrape_value(transformer_link)
    end
  end

  def gem_names
    @gem_names ||= YAML.load_file(options[:file] || 'example.yaml')['gems']
  end

  def name_pattern
    @name_pattern ||= options[:name] || ''
  end

  def top
    @top ||= options[:top].to_i
  end

  def scrape_value(link)
    scraper = Scraper.new(link, browser)
    scraper.scrape
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
