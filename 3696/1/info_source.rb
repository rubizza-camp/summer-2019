require 'singleton'
require 'watir'
require 'webdrivers'
require './scraper'
require './name_to_link_transformer'
class InfoSource
  include Singleton

  def data(init_data)
    file, name_pattern = init_data.values_at(:gems, :name)
    info = source_scrape(file, name_pattern)
    print_error_report(info, file)
    source.close
    [info, init_data[:top_n]]
  end

  private

  def source
    @source ||= Watir::Browser.new(:firefox, headless: true)
  end

  def error_list
    @error_list ||= []
  end

  def print_error_report(info, file)
    print "#{info.size} #{I18n.t('out')} #{file.size} #{I18n.t('processed')}. #{I18n.t('fail')}:"
    error_list.empty? ? puts('none') : puts(error_list)
  end

  def source_scrape(file, name_pattern)
    file.each_with_object({}) do |str, hsh|
      next unless str.start_with?(name_pattern)

      transformer_link = NameToLinkTransformer.new(str).link
      transformer_link == 'no-link' ? error_list << str : hsh[str] = gem_info(transformer_link)
    end
  end

  def gem_info(link)
    scraper = Scraper.new(link, source)
    scraper.scrape
  end
end
