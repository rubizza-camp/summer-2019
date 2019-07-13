require 'mechanize'

# class for get github url something gem and get information about this gem
class GetInformationAboutGem
  attr_reader :temporary_array

  def initialize(name_gem)
    @name_gem = name_gem
    @url = 'https://rubygems.org/'
    @agent = Mechanize.new
    @temporary_array = []
  end

  def information_about_gem
    if such_gem?
      entry_all_values
      temporary_array
    else
      false
    end
  end

  private

  def such_gem?
    page_all_gems
    begin
      github_url
      true
    rescue NoMethodError
      puts "Тo such gem #{@name_gem}"
      false
    end
  end

  def entry_all_values
    entry_value_name
    entry_value_used_by
    entry_value_watch_star_fork
    entry_value_contributors
    entry_value_issues
  end

  def entry_value_name
    temporary_array << @name_gem
  end

  def entry_value_used_by
    github_used_by = @agent.get(github_url + '/network/dependents')
    temporary_array << github_used_by.css("a[class='btn-link selected']").text.gsub(/[^\d,]/, '')
  end

  def entry_value_watch_star_fork
    array_include_watched_stars_forks.each { |iter| temporary_array << iter.text.strip }
  end

  def entry_value_contributors
    arr_conributors = github.css("span[class='num text-emphasized']")
    temporary_array << arr_conributors[3].text.strip
  end

  def entry_value_issues
    temporary_array << github.at('.Counter').text
  end

  def array_include_watched_stars_forks
    @array_include_watched_stars_forks ||= github.css('.social-count')
  end

  def page_all_gems
    form.fields.each { |form| form.value = @name_gem if form.name == 'query' }
    @page_all_gems ||= form.submit
  end

  def github_url
    page_gems = @agent.get(@url + page_all_gems.at('.gems__gem')['href'])
    return @github_url ||= page_gems.at('#code')['href'] if page_gems.at('#code')
    return @github_url ||= page_gems.at('#home')['href'] unless page_gems.at('#code')
  end

  def github
    @github ||= @agent.get github_url
  end

  def form
    page = @agent.get @url
    @form ||= page.forms.first # open form in https://rubygems.org/
  end
end
