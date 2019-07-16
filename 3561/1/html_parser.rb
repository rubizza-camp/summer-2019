require 'open-uri'

class HtmlParser
  def initialize(gems_information)
    @gems_information = gems_information
  end

  def parse
    find_all_information_from_html
    @gems_information
  end

  private

  def find_all_information_from_html
    find_information_from_html('a[class=\'social-count\']', :watchers)
    find_information_from_html('span[class=\'Counter\']', :issues)
    find_information_from_html('a[class=\'btn-link selected\']', :used_by)
    find_information_from_html('a span[class=\'num text-emphasized\']', :contributors)
  end

  def find_information_from_html(request, symbol)
    page = @gems_information[symbol]
    @gems_information[symbol] = search_on_page(request, page)
  end

  def search_on_page(request, page)
    raw_text = page.search(request).text
    match    = raw_text.match(/(\d+)(,\d+)?/)
    match[0].sub(',', '').to_i if match
  end
end
