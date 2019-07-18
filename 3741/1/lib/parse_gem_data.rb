require 'nokogiri'
require_relative '../lib/check_html'
require_relative '../lib/gem_data'

# parsing data from web page of gem
class ParseGemData
  def call(gem_name)
    gem_info = parse_by(gem_name)
    gem_info = create_empty_gem_info(gem_name) if gem_info == 'bad'
    GemData.new(gem_info)
  end

  private

  def parse_by(gem_name)
    html = CheckHtml.new.call(gem_name)
    return create_empty_gem_info(gem_name) if html.nil?
    source_page = Nokogiri::HTML(Kernel.open(html))
    used_by_page = Nokogiri::HTML(Kernel.open(html + '/network/dependents'))
    gem_info = parse_gem_info(source_page, used_by_page)
    gem_info[:name] = gem_name
    gem_info
  end

  def parse_gem_info(source_page, used_by_page)
    {
      used_by:        receive_info(used_by_page, '.btn-link', 1),
      watcher_count:      receive_info(source_page,  '.social-count',    0),
      forks_count:        receive_info(source_page,  '.social-count',    2),
      contributors_count: receive_info(source_page,  '.text-emphasized', 3),
      stars_count:        receive_info(source_page,  '.social-count',    1),
      issues_count:       receive_info(source_page,  '.Counter',         0)
    }
  end

  def create_empty_gem_info(gem_name)
    {
      used_by:        0,
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
end
