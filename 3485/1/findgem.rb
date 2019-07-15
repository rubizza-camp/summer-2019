# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'open-uri'

# :reek:UtilityFunction
# :reek:TooManyStatements
# :reek:TooManyInstanceVariables
class GemsAddres
  attr_reader :name, :used_by, :watched_by, :stars, :forks, :contributors, :issues

  URL = 'https://api.github.com/search/repositories?q='
  END_URL = '&sort=stars&order=desc@per_page=1'
  CONTRIBUTORS = "a span[class='num text-emphasized']"
  WATCHED = '/html/body/div[4]/div/main/div[1]/div/ul/li'
  USED_BY = 'a.btn-link:nth-child(1)'

  def initialize(gems)
    @source_api = HTTParty.get("#{URL}#{gems}#{END_URL}")
    @reponame = repository
    @html = nokogiri
  end

  def nokogiri
    Nokogiri::HTML(::Kernel.open(@reponame[:html_url]))
  end

  def call(_gems)
    @contributors = contributors
    @watched_by = watched
    @used_by = used_by
    @name = @reponame[:name]
    @stars = @reponame[:stargazers_count]
    @forks = @reponame[:forks_count]
    @issues = @reponame[:open_issues_count]
  end

  def cleaner(get_integers)
    get_integers.gsub(/[^0-9]/, '').to_i
  end

  def repository
    values @source_api.to_hash['items'].first
  end

  def values(hash)
    hash.transform_keys(&:to_sym)
  end

  def used_by_stat
    html = Nokogiri::HTML(::Kernel.open("#{@reponame[:html_url]}/network/dependents"))
    used_by = html.css(USED_BY).text
    cleaner(used_by)
  end

  def contributors_stat
    contributors = @html.css(CONTRIBUTORS)[-1].text
    cleaner(contributors)
  end

  def watched
    stars = @html.xpath(WATCHED).select do |find|
      find.text.include? 'Watch'
    end.first.text
    cleaner(stars)
  end
end
