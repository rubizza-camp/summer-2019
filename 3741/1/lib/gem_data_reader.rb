require 'nokogiri'
require 'json'
require_relative '../lib/gem_data'

# parsing data from web page of gem
class GemDataReader
  attr_reader :gem_name

  def initialize(gem_name)
    @html = ''
    @gem_name = gem_name
  end

  def read
    gem_info = parse_by
    gem_info = empty_gem if gem_info == 'bad'
    GemData.new(gem_info)
  end

  private

  def parse_by
    @html = open_url(gem_name)
    return empty_gem unless @html
    gem_data(nokogiri_parse, nokogiri_parse_used_by).merge(name: gem_name)
  end

  def gem_data(source_page, used_by_page)
    {
      used_by:            receive_info(used_by_page, '.btn-link',        1),
      watcher_count:      receive_info(source_page,  '.social-count',    0),
      forks_count:        receive_info(source_page,  '.social-count',    2),
      contributors_count: receive_info(source_page,  '.text-emphasized', 3),
      stars_count:        receive_info(source_page,  '.social-count',    1),
      issues_count:       receive_info(source_page,  '.Counter',         0)
    }
  end

  def empty_gem
    {
      used_by:            0,
      watcher_count:      0,
      stars_count:        0,
      forks_count:        0,
      contributors_count: 0,
      issues_count:       0,
      name:               gem_name
    }
  end

  def receive_info(page, element, number_element)
    page.css(element)[number_element].text.gsub(/\D/, '').to_i
  end

  def nokogiri_parse
    Nokogiri::HTML(Kernel.open(@html))
  end

  def nokogiri_parse_used_by
    Nokogiri::HTML(Kernel.open(@html + '/network/dependents'))
  end

  def open_url(gem_name)
    source_url = Kernel.open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
    JSON.parse(source_url)['source_code_uri']
  end
end
