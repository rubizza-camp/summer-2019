require 'open-uri'
require 'json'
require 'nokogiri'

class GemInfo
  WATCHER_WEIGHT = 0.5
  USED_BY_WEIGHT = 1
  STAR_WEIGHT = 0.7
  CLOSE_ISSUE_WEIGHT = 0.9
  OPEN_ISSUE_WEIGHT = -0.3

  def initialize(gem_names)
    @gem_names = gem_names
    @gem_data = []
  end

  def call
    fill_gem_data
    sort_gems
    @gem_data
  end

  private

  def fill_gem_data
    @gem_names.each do |gem_name|
      gem_repo = JSON.parse(
        open("https://rubygems.org/api/v1/gems/#{gem_name}.json").read
      )['source_code_uri'][%r{\/[^.:\/]+\/[^.:\/]+}]
      github_info = JSON.parse(open("https://api.github.com/repos#{gem_repo}").read)
      gem_stats = { name: gem_name }.merge(gem_statistic(gem_repo, github_info))
      @gem_data << gem_stats
    end
  end

  def gem_statistic(gem_repo, github_info)
    {
      used_by: dependencies(gem_repo),
      watchers_count: github_info['watchers_count'],
      stargazers_count: github_info['stargazers_count'],
      forks_count: github_info['forks_count'],
      contributors: contributors(gem_repo),
      open_issues: issues_count(gem_repo, 'Open'),
      close_issues: issues_count(gem_repo, 'Close')
    }
  end

  def number_form_string(string)
    string.split('').select { |ch| ch =~ /\d+/ }.join.to_i
  end

  def contributors(gem_repo)
    doc = Nokogiri::HTML(open("https://github.com#{gem_repo}/contributors_size"))
    number_text = doc.search('span').text
    number_form_string(number_text)
  end

  def issues_count(gem_repo, type)
    doc = Nokogiri::HTML(open("https://github.com#{gem_repo}/issues"))
    number_text = doc.search('a').select { |el| el.text =~ /\d+ #{type}/ }.first.text
    number_form_string(number_text)
  end

  def dependencies(gem_repo)
    doc = Nokogiri::HTML(open("https://github.com#{gem_repo}/network/dependents"))

    number_text = doc.search('a').select { |el| el.text =~ /Repositories/ }[0].text
    number_form_string(number_text)
  end

  def gem_score(gem)
    gem[:used_by] * USED_BY_WEIGHT +
      gem[:watchers_count] * WATCHER_WEIGHT +
      gem[:stargazers_count] * STAR_WEIGHT +
      gem[:close_issues] * CLOSE_ISSUE_WEIGHT +
      gem[:open_issues] * OPEN_ISSUE_WEIGHT
  end

  def sort_gems
    @gem_data = @gem_data.sort do |first, second|
      gem_score(first) <=> gem_score(second)
    end.reverse
  end
end
