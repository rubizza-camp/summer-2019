class PageFetcher
  URI_RUBY_GEMS = 'https://rubygems.org/gems/'.freeze

  attr_reader :gem_name, :agent, :http_page

  def initialize(gem_name, agent)
    @agent = agent
    @gem_name = gem_name
    @http_page = github_page
  end

  def page_exist?
    agent.head(gem_url)
    true
  rescue Mechanize::ResponseCodeError
    false
  end

  def url_in_github
    http_page.at('#code')['href']
  end

  private

  def github_page
    agent.get(gem_url) if page_exist?
  end

  def gem_url
    URI.join(URI_RUBY_GEMS, gem_name)
  end
end
