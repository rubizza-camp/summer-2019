require 'mechanize'

# class for get github url something gem and get information about this gem
class GemInfoFetcher
  attr_reader :temporary_array

  URL = 'https://rubygems.org/'.freeze

  def initialize(name_gem)
    @name_gem = name_gem
    @temporary_array = []
  end

  def information_about_gem
    all_values if such_gem?
    temporary_array
  end

  private

  def such_gem?
    begin
      page_gems
    rescue Mechanize::ResponseCodeError
      puts "Тo such gem #{@name_gem}"
      return false
    end
    github_url
  end

  def all_values
    value_name_gem
    value_used_by
    value_watch_star_fork
    value_contributors
    value_issues
  end

  def value_name_gem
    temporary_array << @name_gem
  end

  def value_used_by
    github_used_by = agent.get(github_url + '/network/dependents')
    temporary_array << github_used_by.css("a[class='btn-link selected']").text.gsub(/[^\d,]/, '')
  end

  def value_watch_star_fork
    array_include_watched_stars_forks.each { |iter| temporary_array << iter.text.strip }
  end

  def value_contributors
    arr_conributors = github.css("span[class='num text-emphasized']")
    temporary_array << arr_conributors[3].text.strip
  end

  def value_issues
    temporary_array << github.at('.Counter').text
  end

  def array_include_watched_stars_forks
    @array_include_watched_stars_forks ||= github.css('.social-count')
  end

  def page_gems
    @page_gems ||= agent.get(URL + 'gems/' + @name_gem)
  end

  def github_url
    return @github_url ||= page_gems.at('#code')['href'] if page_gems.at('#code')
    return @github_url ||= page_gems.at('#home')['href'] unless page_gems.at('#code')
  end

  def github
    @github ||= agent.get(github_url)
  end

  def agent
    @agent ||= Mechanize.new
  end
end
