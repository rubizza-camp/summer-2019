# class for getting links
class LinksModifier
  attr_reader :git_page, :used_by_page

  def initialize(gem_name)
    @agent = Mechanize.new
    @ruby_gems_page = find_gem_page(gem_name)
    @git_page = find_git_page
    @used_by_page = modifier_url_for_used_by
  end

  def find_git_page
    links = link_in_source_code || link_in_homepage
    git_page = links.click
    git_page
  end

  def link_in_source_code
    link = @ruby_gems_page.links.find do |page_link|
      page_link.text.include?('Source Code')
    end
    link
  end

  def link_in_homepage
    link = @ruby_gems_page.links.find do |page_link|
      page_link.text.include?('Homepage')
    end
    link
  end

  def find_gem_page(gem_name)
    ruby_gems_link = "https://rubygems.org/gems/#{gem_name}/"
    page = @agent.get(ruby_gems_link)
    page
  end

  def modifier_url_for_used_by
    page = @agent.get("#{@git_page.uri}/network/dependents")
    page
  end
end
