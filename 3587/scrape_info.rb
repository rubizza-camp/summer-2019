require './links_modifier.rb'
# class that get info about gem from git
class Scrape
  attr_reader :watch
  def initialize(page, used_by_page, name)
    @page = page
    @watch = [name]
    find_info_without_used_by
    @used_by_page = used_by_page
    find_used_by
  end

  def find_forks_stars_watched
    temp_array = []
    @page.css('a.social-count').each do |score|
      temp_array << score.text.gsub!(/[^\d]/, '').to_i
    end
    temp_array
  end

  def find_contributors
    contributors = @page.css("span[class ='num text-emphasized']")[3].text.strip
    contributors = 0 if contributors.empty?
    contributors
  end

  def find_issues
    issues = @page.at_css('.Counter').text
    issues
  end

  def find_info_without_used_by
    @watch += find_forks_stars_watched
    @watch << find_contributors.to_i
    @watch << find_issues.to_i
  end

  def find_used_by
    used_by = @used_by_page.css("a[class = 'btn-link selected']").text
    @watch << used_by.gsub!(/[^\d]/, '').to_i
  end
end
