require 'nokogiri'
require 'json'
require_relative '../lib/gem_info_decorator'

# parsing data from web page of gem
class GemDataReader
  def self.read(gem_name)
    gem_data_reader = GemDataReader.new(gem_name)
    gem_data_reader.read
    gem_data_reader.gem_info
  end

  attr_reader :gem_name
  attr_reader :gem_info

  def initialize(gem_name)
    @gem_name = gem_name
  end

  def read
    return GemInfoDecorator.new(empty_gem) unless html
    @gem_info = GemInfoDecorator.new(gem_data.merge(name: gem_name))
  end

  private

  def gem_data
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

  def source_page
    @source_page ||= Nokogiri::HTML(Kernel.open(html))
  end

  def used_by_page
    @used_by_page ||= Nokogiri::HTML(Kernel.open(html + '/network/dependents'))
  end

  def html
    @html ||= JSON.parse(source_url)['source_code_uri']
  end

  def source_url
    @source_url ||= Kernel.open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
  end
end
