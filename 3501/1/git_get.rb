require 'net/http'
require 'json'
require 'nokogiri'
require 'open-uri'

class GitGet
  attr_reader :rep_hash
  attr_reader :repository_full_name
  attr_reader :rep_inf
  attr_reader :search_html_result

  def load_body_hash(url)
    Net::HTTP.start(url.host, url.port,
                    use_ssl: url.scheme == 'https') do |http|
      request = Net::HTTP::Get.new url
      response = http.request request
      return JSON.parse(response.body)
    end
  end

  def load_html(url)
    ::Nokogiri::HTML(::Kernel.open(url))
  end

  def number_from_selector(selector)
    inner_html = @search_html_result.css(selector)[0].text
    inner_html = inner_html.gsub(/,/, '')[/[0-9]+/]
    number = inner_html.to_i
    number
  end

  def umber_from_selector_class(selector1, selector2)
    inner_html = @search_html_result.css(selector1).css(selector2)[3].text
    inner_html = inner_html.gsub(/,/, '')[/[0-9]+/]
    number = inner_html.to_i
    number
  end

  def hash_api_first_item(name_one, name_two)
    items = @rep_hash[name_one]
    return 'undefined' if items.nil?

    @rep_hash[name_one].first[name_two]
  end

  def load_from_api(url)
    @rep_hash = load_body_hash url
    @repository_full_name = hash_api_first_item('items', 'full_name')
    @rep_inf[:full_name] = hash_api_first_item('items', 'full_name')
    @rep_inf[:name] = hash_api_first_item('items', 'name')
    @rep_inf[:stargazers_count] = hash_api_first_item('items', 'stargazers_count')
    @rep_inf[:forks_count] = hash_api_first_item('items', 'forks_count')
    @rep_inf[:open_issues_count] = hash_api_first_item('items', 'open_issues_count')
    @rep_inf[:score] = hash_api_first_item('items', 'score')
  end

  def set_default_from_html
    @rep_inf[:used_by] = 0
    @rep_inf[:watchers] = 0
    @rep_inf[:contributors] = 0
  end

  def search_from_html
    url = URI.parse("#{@rep_hash['items'].first['html_url']}/network/dependents")
    @search_html_result = load_html url
    @rep_inf[:used_by] = number_from_selector "a[class='btn-link selected']"
    @rep_inf[:watchers] = number_from_selector "a[href='/#{@repository_full_name}/watchers']"
    url = URI.parse(@rep_hash['items'].first['html_url'])
    @search_html_result = load_html url
    @rep_inf[:contributors] = umber_from_selector_class('.num', '.text-emphasized')
  end

  def load_from_html
    items = @rep_hash['items']
    if items.nil?
      set_default_from_html
    else
      search_from_html
    end
  end

  def initialize(repo_name)
    @rep_inf = {}
    # Searching date through github api
    url = URI.parse("https://api.github.com/search/repositories?q=#{repo_name}
      &sort=stars&order=desc@per_page=1")
    load_from_api url
    # Missing data loading through github html
    load_from_html
  end
end
