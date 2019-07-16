require 'mechanize'

# class for get github url something gem and get information about this gem
class GemInfoFetcher
  RUBYGEMS_URL = 'https://rubygems.org/'.freeze
  SHOT_URL_USED_BY = '/network/dependents'.freeze
  USED_BY_CSS_CLASS = "a[class='btn-link selected']".freeze
  CONTRIBUTORS_CSS_CLASS = "span[class='num text-emphasized']".freeze
  WATCH_STAR_FORK_CSS_CLASS = '.social-count'.freeze

  def initialize(name_gem)
    @name_gem = name_gem
  end

  def information_about_gem
    hash_with_info_about_gem if gem_exists?
  end

  private

  def gem_exists?
    gem_page
    true
  rescue Mechanize::ResponseCodeError
    puts "No such gem #{@name_gem}"
    false
  end

  def hash_with_info_about_gem
    @hash_with_info_about_gem ||= {
      name: @name_gem,
      used_by: value_used_by,
      watched_by: hash_include_watched_stars_forks[:watched_by],
      stars: hash_include_watched_stars_forks[:stars],
      forks: hash_include_watched_stars_forks[:forks],
      contributors: value_contributors,
      issues: github.at('.Counter').text
    }
  end

  def value_used_by
    github_used_by = agent.get(github_url + SHOT_URL_USED_BY)
    github_used_by.css(USED_BY_CSS_CLASS).text.gsub(/[^\d,]/, '')
  end

  def hash_include_watched_stars_forks
    @hash_include_watched_stars_forks ||= {
      watched_by: array_include_watched_stars_forks[0].text.strip,
      stars: array_include_watched_stars_forks[1].text.strip,
      forks: array_include_watched_stars_forks[2].text.strip
    }
  end

  def array_include_watched_stars_forks
    @array_include_watched_stars_forks ||= github.css(WATCH_STAR_FORK_CSS_CLASS)
  end

  def value_contributors
    arr_conributors = github.css(CONTRIBUTORS_CSS_CLASS)
    arr_conributors[3].text.strip
  end

  def gem_page
    @gem_page ||= agent.get(RUBYGEMS_URL + 'gems/' + @name_gem)
  end

  def github_url
    return @github_url ||= gem_page.at('#code')['href'] if gem_page.at('#code')
    @github_url ||= gem_page.at('#home')['href'] unless gem_page.at('#code')
  end

  def github
    @github ||= agent.get(github_url)
  end

  def agent
    @agent ||= Mechanize.new
  end
end
