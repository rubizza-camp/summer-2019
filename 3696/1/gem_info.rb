require './scraper'
# The same as top_gems.rb(especially in popularity)
# :reek:InstanceVariableAssumption and :reek:TooManyInstanceVariables
class GemInfo
  include Scraper
  attr_reader :used_by, :watched_by, :starred_by, :forked_by, :contributors, :issues, :name
  def to_s
    "#{@name}  | used by #{@used_by} | watched by #{@watched_by} |  #{@starred_by} stars |"\
    "#{@forked_by} forks | #{@contributors} contributors | #{@issues} issues |"
  end

  def get_original_page_info(link)
    link = link.split('/').take(5).join('/')
    page = Nokogiri::HTML(URI.open(link))
    @watched_by, @starred_by, @forked_by = get_watches_stars_forks page
    _, _, _, @contributors = get_commits_branches_releases_contributors page
    @issues = get_issues page
  end

  def get_modified_url_info(link)
    link = link.split('/').take(5).join('/')
    new_link = link + FOR_USED_BY
    github_page = Nokogiri::HTML(URI.open(new_link))
    @used_by = get_used_by github_page
  end

  def initialize(name, link)
    @name = name
    get_original_page_info link
    get_modified_url_info link
  end

  def popularity
    @used_by + @watched_by + @starred_by * 0.8 + @forked_by * 0.8 + @contributors * 0.5 +
      issues * 0.5
  end
end
