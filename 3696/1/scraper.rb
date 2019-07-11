module Scraper
  FOR_USED_BY = '/network/dependents'.freeze
  URL = 'https://rubygems.org/gems/'.freeze
  # I can't think of better place for this method, because Monkey Patching is bad and,
  # as I understand modules, they can be just a bunch of methods without dependency on the state
  # :reek:UtilityFunction
  def to_natural(num)
    num.delete(',').to_i
  end

  # :reek:UtilityFunction
  def get_github_link(url)
    doc = Nokogiri::HTML(URI.open(URL + url))
    all_links = doc.css('a#code').map { |link| link.attribute('href').to_s }
    all_links.first
  end

  # :reek:UtilityFunction
  def repo_link?(link)
    link.include?('github') && !(link.match? 'rubygems')
  end

  def get_watches_stars_forks(page)
    page.css('.social-count').to_a.map { |item| to_natural(item.text.strip) }
  end

  def get_used_by(page)
    page.to_s[/(\d*,?\d+)\s*\n*\s*(Repositories)/]
    to_natural(Regexp.last_match(1))
  end

  def get_commits_branches_releases_contributors(page)
    page.css('.num.text-emphasized').to_a.map { |item| to_natural(item.text.strip) }
  end

  def get_issues(page)
    to_natural(page.css('.Counter').to_a[0].text)
  end
end
