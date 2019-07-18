require 'open-uri'
require 'json'
require 'nokogiri'

class GemInfo
  WEIGHTS = {
    watchers_count: 0.5,
    used_by: 1,
    stargazers_count: 0.7,
    close_issues: 0.9,
    open_issues: -0.3
  }.freeze

  def initialize(gem_name, constants)
    @gem_name = gem_name
    @score_weights = constants
  end

  def call
    fill_skiped_constants
    gem_data
  end

  private

  def fill_skiped_constants
    WEIGHTS.each_key do |constant|
      @score_weights[constant] ||= WEIGHTS[constant]
    end
  end

  def gem_data
    @gem_data ||= fill_gem_data
  end

  def fill_gem_data
    gem_repo = JSON.parse(
      open("https://rubygems.org/api/v1/gems/#{@gem_name}.json").read
    )['source_code_uri'][%r{\/[^.:\/]+\/[^.:\/]+}]
    github_info = JSON.parse(open("https://api.github.com/repos#{gem_repo}").read)
    { name: @gem_name }.merge(gem_statistic(gem_repo, github_info))
  end

  def gem_statistic(gem_repo, github_info)
    gem = {
      used_by: dependencies(gem_repo),
      watchers_count: github_info['watchers_count'],
      stargazers_count: github_info['stargazers_count'],
      forks_count: github_info['forks_count'],
      contributors: contributors(gem_repo),
      open_issues: issues_count(gem_repo, 'Open'),
      close_issues: issues_count(gem_repo, 'Close')
    }
    gem.merge(score: gem_score(gem))
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

  def gem_parameter_weigh(gem, param)
    gem[param] * @score_weights[param]
  end

  def gem_score(gem)
    gem_parameter_weigh(gem, :used_by) +
      gem_parameter_weigh(gem, :watchers_count) +
      gem_parameter_weigh(gem, :stargazers_count) +
      gem_parameter_weigh(gem, :close_issues) +
      gem_parameter_weigh(gem, :open_issues)
  end
end
