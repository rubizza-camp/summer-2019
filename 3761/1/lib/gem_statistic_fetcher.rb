class GemStatisticFetcher
  attr_reader :gem_name, :rubygems_gem_page, :agent

  def initialize(gem_name, rubygems_gem_page, agent)
    @gem_name = gem_name
    @rubygems_gem_page = rubygems_gem_page
    @agent = agent
  end

  def self.call(gem_name, rubygems_gem_page, agent)
    new(gem_name, rubygems_gem_page, agent).call
  end

  def call
    statistic.merge(used_by: used_by, gem: gem_name)
  end

  private

  def statistic
    page_gem_in_github = PageFetcher.new(rubygems_gem_page.url_in_github, agent)
    PageParser.data_without_used(page_gem_in_github.http_page)
  end

  def used_by
    url_with_used = rubygems_gem_page.url_in_github + '/network/dependents'
    page_gem_with_used_by = PageFetcher.new(url_with_used, agent)
    PageParser.used_by(page_gem_with_used_by.http_page)
  end
end
