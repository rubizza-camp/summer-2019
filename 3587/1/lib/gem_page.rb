class GemPages
  attr_reader :github_page, :used_by_page, :agent

  RUBYGEMS_URL = 'https://rubygems.org/gems/'.freeze

  def initialize(gem_name, agent)
    @agent = agent
    @ruby_gems_page = gem_page(gem_name)
    @github_page = git_page(gem_name)
    @used_by_page = page_used_by
  end

  def git_page(gem_name)
    return link_in_source_code.click if link_in_source_code.href.include?('github')
    raise MechanizeError, "rubygems.org contain other link #{link_in_source_code.href}"
  rescue NoMethodError
    raise MechanizeError, "#{gem_name} github link not found on rubygems.org"
  end

  def link_in_source_code
    @ruby_gems_page.links.find do |page_link|
      page_link.text.include?('Source Code')
    end
  end

  def gem_page(gem_name)
    @agent.get(URI.join(RUBYGEMS_URL, gem_name))
  rescue Mechanize::ResponseCodeError
    raise MechanizeError, 'not found on rubygems.org'
  end

  def page_used_by
    @agent.get("#{@github_page.uri}/network/dependents")
  end
end
