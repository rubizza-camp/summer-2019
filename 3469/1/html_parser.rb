class HtmlParser
  USED_BY_REQUEST = 'a[class=\'btn-link selected\']'.freeze
  CONTRIBUTORS_REQUEST = "a span[class='num text-emphasized']".freeze
  def initialize(hash_of_data)
    @gem_information = {}
    @hash_of_data = hash_of_data
    @page = hash_of_data[:page]
  end

  def call
    name = @hash_of_data[:name]
    watchers_request = "li a[href=\"/#{name}/watchers\"]"
    issues_request   = "span a[href=\"/#{name}/issues\"]"
    information_about_gem(watchers_request, issues_request)
    @gem_information
  end

  private

  def information_about_gem(watchers_request, issues_request)
    @gem_information[:watchers]     = search_in_page(watchers_request)
    @gem_information[:issues]       = search_in_page(issues_request)
    @gem_information[:used_by]      = search_in_page(USED_BY_REQUEST)
    @page = @hash_of_data[:page_for_contributors]
    @gem_information[:contributors] = search_in_page(CONTRIBUTORS_REQUEST)
  end

  def search_in_page(request)
    raw_text = @page.search(request).text
    match_info = raw_text.match(/(\d+)((,\d+)?)*/)
    match_info[0].delete(',').to_i if match_info
  end
end
