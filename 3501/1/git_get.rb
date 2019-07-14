# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'open-uri'

#:reek:TooManyStatements
#:reek:TooManyInstanceVariables
class GetGemDataFromGit
  class RepositoryNotFoundError < RuntimeError
  end
  class PermissionDeniedError < RuntimeError
  end
  #:reek:Attribute
  attr_accessor :name, :used_by, :watched_by, :stars, :forks, :contributors, :issues

  API_URL = 'https://api.github.com/search/repositories?q='
  PARAMS = '&sort=stars&order=desc@per_page=1'
  CONTRIBUTORS_CSS_SELECTOR = "a span[class='num text-emphasized']"
  WATCHED_CSS_SELECTOR = '/html/body/div[4]/div/main/div[1]/div/ul/li'
  USED_BY_CSS_SELECTOR = 'a.btn-link:nth-child(1)'

  def initialize(gem_name)
    @api_response = HTTParty.get("#{API_URL}#{gem_name}#{PARAMS}")
    @repo = repository
    @html = use_nokogiri
    self
  rescue RepositoryNotFoundError => error
    default_data(gem_name, error.message)
    self
  rescue PermissionDeniedError => error
    default_data(gem_name, error.message)
    self
  end

  def call(gem_name)
    check_for_errors
    pull_from_api
    self
  rescue RepositoryNotFoundError => error
    default_data(gem_name, error.message)
    self
  rescue PermissionDeniedError => error
    default_data(gem_name, error.message)
    self
  end

  private

  def check_for_errors
    message = @api_response.response.inspect
    unless message.include?('200')
      error_message = "error #{message[/[0-9]+/]}"
      raise(PermissionDeniedError, error_message)
    end
    raise(RepoNotFoundError, 'not found') if @api_response.to_hash['items'].empty?
  end

  def pull_from_api
    @name = @repo[:name]
    @stars = @repo[:stargazers_count]
    @forks = @repo[:forks_count]
    @issues = @repo[:open_issues_count]
    @contributors = contributors_count
    @watched_by = watched_by_count
    @used_by = used_by_count
  end

  def default_data(gem_name, message)
    @name = "#{gem_name} - #{message}"
    @used_by = 0
    @watched_by = 0
    @stars = 0
    @forks = 0
    @contributors = 0
    @issues = 0
  end

  def use_nokogiri
    Nokogiri::HTML(::Kernel.open(@repo[:html_url]))
  end

  def repository
    check_for_errors
    symbolize(@api_response.to_hash['items'].first)
  end

  def symbolize(hash)
    hash.transform_keys(&:to_sym)
  end

  def contributors_count
    contributors = @html.css(CONTRIBUTORS_CSS_SELECTOR).last.text
    to_num(contributors)
  end

  def watched_by_count
    stars = @html.xpath(WATCHED_CSS_SELECTOR).select do |el|
      el.text.include? 'Watch'
    end.first.text
    to_num(stars)
  end

  def used_by_count
    html = Nokogiri::HTML(::Kernel.open("#{@repo[:html_url]}/network/dependents"))
    used_by = html.css(USED_BY_CSS_SELECTOR).text
    to_num(used_by)
  end

  def to_num(num_string)
    num_string.gsub(/[^0-9]/, '').to_i
  end
end
