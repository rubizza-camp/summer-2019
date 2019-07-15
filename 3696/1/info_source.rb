require 'singleton'
require 'watir'
require 'webdrivers'
require './scraper'
require './parse_exception'
require './name_to_link_transformer'
class InfoSource
  include Singleton

  def data(init_data)
    file, name_pattern = init_data.values_at(:gems, :name)
    { data: scrape_session(file, name_pattern), top: init_data[:top_n] }
  rescue NoMethodError
    puts I18n.t('gem_key_error')
    exit
  end

  private

  def source
    @source ||= Watir::Browser.new(:firefox, headless: true)
  end

  def error_list
    @error_list ||= []
  end

  def print_error_report(info, file)
    puts "#{info.size} #{I18n.t('out')} #{file.size} #{I18n.t('processed')}. #{I18n.t('fail')}:"
    error_list.empty? ? puts('none') : puts(error_list)
  end

  #:reek:UncommunicativeVariableName for exception
  def source_scrape(file, name_pattern)
    file.each_with_object({}) do |str, hsh|
      next unless str.start_with?(name_pattern)

      add_gem_info(hsh, str)
    rescue ParseException => e
      error_list << e.message
    end
  end

  def scrape_session(file, name_pattern)
    info = source_scrape(file, name_pattern)
    print_error_report(info, file)
    source.close
    info
  end

  def add_gem_info(hsh, str)
    transformer_link = source_link(str)
    transformer_link == 'no-link' ? error_list << str : hsh[str] = gem_info(transformer_link)
  end

  def source_link(str)
    NameToLinkTransformer.new(str).link
  end

  def gem_info(link)
    scraper = Scraper.new(link, source)
    scraper.scrape
  end
end
