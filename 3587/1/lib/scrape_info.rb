class Scraper
  CONTRIBUTORS_CSS_CLASS = "span[class ='num text-emphasized']".freeze
  USED_BY_CSS_CLASS = "a[class = 'btn-link selected']".freeze

  def initialize(gem_name, agent)
    @gem_name = gem_name
    @agent = agent
  end

  def hash_with_info_about_gem
    @hash_with_info_about_gem ||= {
      watch: watch_by,
      star: stars,
      fork: forks,
      used_by: used_by.gsub!(/[^\d]/, '').to_i,
      contributors: contributors,
      issues: issues
    }
  end

  private

  def watch_by
    page.css('.social-count')[0].text.gsub!(/[^\d]/, '').to_i
  end

  def stars
    page.css('.social-count')[1].text.gsub!(/[^\d]/, '').to_i
  end

  def forks
    page.css('.social-count')[2].text.gsub!(/[^\d]/, '').to_i
  end

  def contributors
    page.css(CONTRIBUTORS_CSS_CLASS)[3].text.gsub!(/[^\d]/, '').to_i
  end

  def issues
    page.at_css('.Counter').text.to_i
  end

  def used_by
    git_page_object.used_by_page.css(USED_BY_CSS_CLASS).text
  end

  def page
    git_page_object.github_page
  end

  def git_page_object
    @git_page_object ||= GemPages.new(@gem_name, @agent)
  end
end
