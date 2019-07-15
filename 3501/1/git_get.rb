# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'open-uri'

class GetGemDataFromGit
  class RepositoryNotFoundError < RuntimeError
  end
  class PermissionDeniedError < RuntimeError
  end

  attr_reader :git_data, :api_response, :repo, :html

  def initialize(gem_name)
    @git_data = {}
    @api_response = HTTParty.get("#{API_URL}#{gem_name}#{PARAMS}")
    @repo = repository
    @html = use_nokogiri
  rescue RepositoryNotFoundError => error
    default_data(gem_name, error.message)
  rescue PermissionDeniedError => error
    default_data(gem_name, error.message)
  end

  def call(gem_name)
    pull_from_api
  rescue RepositoryNotFoundError => error
    default_data(gem_name, error.message)
  rescue PermissionDeniedError => error
    default_data(gem_name, error.message)
  end

  def self.call(gem_name)
    new(gem_name).call(gem_name)
  end

  private

  API_URL = 'https://api.github.com/search/repositories?q='
  PARAMS = '&sort=stars&order=desc@per_page=1'
  CONTRIBUTORS_CSS_SELECTOR = "a span[class='num text-emphasized']"
  WATCHED_CSS_SELECTOR = '/html/body/div[4]/div/main/div[1]/div/ul/li'
  USED_BY_CSS_SELECTOR = 'a.btn-link:nth-child(1)'

  def pull_from_api
    check_for_errors
    pull_from_api_next
  end

  def check_for_errors
    message = @api_response.response.inspect
    unless message.include?('200')
      error_message = "error #{message[/[0-9]+/]}"
      raise(PermissionDeniedError, error_message)
    end
    raise(RepoNotFoundError, 'not found') if @api_response.to_hash['items'].empty?
  end

  def pull_from_api_next
    @git_data[:name] = @repo[:name]
    @git_data[:stars] = @repo[:stargazers_count]
    @git_data[:forks] = @repo[:forks_count]
    @git_data[:issues] = @repo[:open_issues_count]
    pull_from_site
  end

  def pull_from_site
    @git_data[:contributors] = contributors_count
    @git_data[:watched_by] = watched_by_count
    @git_data[:used_by] = used_by_count
    self
  end

  def default_data(gem_name, message)
    @git_data[:name] = "#{gem_name} - #{message}"
    @git_data[:issues] = 0
    @git_data[:stars] = 0
    @git_data[:forks] = 0
    default_data_from_site
  end

  def default_data_from_site
    @git_data[:contributors] = 0
    @git_data[:used_by] = 0
    @git_data[:watched_by] = 0
    self
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
