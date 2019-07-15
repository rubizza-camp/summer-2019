# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'open-uri'

class ParseGemStatsFromGitHub
  class RepositoryNotFoundError < RuntimeError
  end
  class PermissionDeniedError < RuntimeError
  end
  URL = 'https://api.github.com/search/repositories?q='
  END_URL = '&sort=stars&order=desc@per_page=1'
  CONTRIBUTORS = "a span[class='num text-emphasized']"
  WATCHED = '/html/body/div[4]/div/main/div[1]/div/ul/li'
  USED_BY = 'a.btn-link:nth-child(1)'
  attr_reader :stats_from_git, :sourse_api, :repo, :html

  def initialize(gems)
    @stats_from_git = Hash.new(0)
    @sourse_api = HTTParty.get("#{URL}#{gems}#{END_URL}")
    @repo = repository
    @html = nokogiri
  rescue RepositoryNotFoundError(error)
    default_data_from_api(gems, error.message)
  rescue PermissionDeniedError(error)
    default_data_from_api(gems, error.message)
  end

  def call(gems)
    data_from_api
  rescue RepositoryNotFoundError(error)
    default_data_from_api(gems, error.message)
  rescue PermissionDeniedError(error)
    default_data_from_api(gems, error.message)
  end

  def self.call(gems)
    new(gems).call(gems)
  end

  private

  def data_from_api
    check_for_errors
    pull_from_api
    select_from_site
  end

  def check_for_errors
    unless @sourse_api.code == 200
      error_message = 'permission denied'
      raise(PermissionDeniedError, error_message)
    end
    raise(RepoNotFoundError, 'not found') if @sourse_api.to_hash['items'].empty?
  end

  def pull_from_api
    @stats_from_git[:name] = @repo[:name]
    @stats_from_git[:stars] = @repo[:stargazers_count]
    @stats_from_git[:forks] = @repo[:forks_count]
    @stats_from_git[:issues] = @repo[:open_issues_count]
  end

  def select_from_site
    @stats_from_git[:contributors] = contributors_count
    @stats_from_git[:watched_by] = watched_by_count
    @stats_from_git[:used_by] = used_by_count
    self
  end

  def default_data_from_api(gems, message)
    @stats_from_git[:name] = "#{gems} - #{message}"
    @stats_from_git[:issues]
    @stats_from_git[:stars]
    @stats_from_git[:forks]
    default_data_from_site
  end

  def default_data_from_site
    @stats_from_git[:contributors]
    @stats_from_git[:used_by]
    @stats_from_git[:watched_by]
    self
  end

  def nokogiri
    Nokogiri::HTML(::Kernel.open(@repo[:html_url]))
  end

  def repository
    check_for_errors
    symbolize(@sourse_api.to_hash['items'].first)
  end

  def symbolize(hash)
    hash.transform_keys(&:to_sym)
  end

  def contributors_count
    contributors = @html.css(CONTRIBUTORS).last.text
    cleaner(contributors)
  end

  def watched_by_count
    stars = @html.xpath(WATCHED).select do |el|
      el.text.include? 'Watch'
    end.first.text
    cleaner(stars)
  end

  def used_by_count
    html = Nokogiri::HTML(::Kernel.open("#{@repo[:html_url]}/network/dependents"))
    used_by = html.css(USED_BY).text
    cleaner(used_by)
  end

  def cleaner(string)
    string.gsub(/[^0-9]/, '').to_i
  end
end
