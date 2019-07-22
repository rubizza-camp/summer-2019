class PageParser
  attr_reader :page

  PARSER_DATA = {
    used_by: 0,
    watch: 0,
    star: 0,
    fork: 0,
    contributors: 0,
    issues: 0
  }.freeze

  def initialize(page)
    @page = page
  end

  def self.data_without_used(page)
    new(page).data_without_used
  end

  def data_without_used
    parser_data = data.map do |(key, value)|
      [key.text.strip.downcase.to_sym, value.text.strip.tr(',', '_').to_i]
    end
    usefull_data(parser_data)
  end

  def self.used_by(page)
    page.at('.Box-header a').text.strip.tr(',', '_').to_i
  end

  private

  def data
    parser_data = find_first_line
    parser_data += find_second_line
    parser_data += find_third_line
    parser_data
  end

  def find_first_line
    page.css('.pagehead-actions li').map do |link|
      link.css('a')
    end
  end

  def find_second_line
    page.css('.numbers-summary li a').map do |link|
      count = link.css('span')
      remove_span(link)
      [link, count]
    end
  end

  def find_third_line
    page.css('.reponav span a').map do |link|
      span = link.css('span')
      next unless span.count == 2
      span
    end.compact
  end

  def usefull_data(parser_data)
    parser_data.compact.to_h.keep_if { |key, _value| PARSER_DATA.key? key }
  end

  def remove_span(iter)
    iter.children.each { |tag| tag.remove if tag.name == 'span' }
  end
end
