# frozen_string_literal: true

require 'singleton'
require 'watir'
require 'webdrivers'
require './scraper'
require './parse_exception'
require './name_to_link_transformer'
class RepoAdapter
  def initialize(gems: 'no-file', name: '', top_n: 0)
    @file = gems
    @name_pattern = name
    @top = top_n
  end

  def data
    adapt_for_presenter(scrape_session)
  rescue NoMethodError
    puts I18n.t('gem_key_error')
    exit
  end

  private

  attr_reader :file, :name_pattern, :top

  PATH_TO_WEIGHTS = 'weights.yaml'

  def error_list
    @error_list ||= []
  end

  def print_error_report(info)
    puts "#{info.size} #{I18n.t('out')} #{file.size} #{I18n.t('processed')}. #{I18n.t('fail')}:"
    error_list.empty? ? puts('none') : puts(error_list)
  end

  def source_scrape
    file.filter { |str| str.start_with?(name_pattern) }.each_with_object({}) do |str, hsh|
      add_gem_info(hsh, str)
    rescue ParseException => parsing_error
      error_list << parsing_error.message
    end
  end

  def scrape_session
    info = source_scrape
    print_error_report(info)
    Scraper.class_browser.close
    info
  end

  def add_gem_info(hsh, str)

    transformer_result = transformer_data(str)
    transformer_result == 'error' ? error_list << str : hsh[str] = gem_info(transformer_result)
  end

  def transformer_data(str)
    NameToLinkTransformer.new(str).data
  end

  def gem_info(for_scrape_adress)
    scraper = Scraper.new(for_scrape_adress)
    scraper.scrape
  end

  def adapt_for_presenter(hash)
    table_rows = add_names_and_sort(hash)
    top.zero? ? table_rows : table_rows.take(top)
  end

  def weights
    @weights ||= YAML.load_file(PATH_TO_WEIGHTS)['weights']
                     .transform_keys(&:to_sym)
  end

  def add_names_and_sort(info_hash)
    hash_values = info_hash.map { |key, value| [key, value.merge(name: key)] }.map(&:last)
    hash_values.sort_by { |value| -popularity(value) }
  end

  def popularity(info)
    weights.sum { |key, weight| weight * info[key] }
  end
end
