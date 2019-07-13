require 'nokogiri'
require 'httparty'
require 'open-uri'

#:reek:TooManyStatements
#:reek:TooManyInstanceVariables
class GetGemDataFromGit
  class GetGemDataFromGitException < RuntimeError
  end

  API_URL = 'https://api.github.com/search/repositories?q='.freeze
  PARAMS = '&sort=stars&order=desc@per_page=1'.freeze
  CONTRIBUTORS_CSS_SELECTOR = "a span[class='num text-emphasized']".freeze
  WATCHED_CSS_SELECTOR = '/html/body/div[4]/div/main/div[1]/div/ul/li'.freeze
  USED_BY_CSS_SELECTOR = 'a.btn-link:nth-child(1)'.freeze

  attr_reader :name, :used_by, :watched_by, :stars, :forks, :contributors, :issues
  #:reek:UncommunicativeVariableName
  def initialize(gem_name)
    @api_response = HTTParty.get("#{API_URL}#{gem_name}#{PARAMS}")
    @repo = repository
    @html = use_nokogiri
    call_from_response
  rescue GetGemDataFromGitException => e
    repositories_not_found(gem_name, e.message)
  end

  private

  def call_from_response
    @name = @repo[:name]
    @stars = @repo[:stargazers_count]
    @forks = @repo[:forks_count]
    @issues = @repo[:open_issues_count]
    @contributors = contributors_count
    @watched_by = watched_by_count
    @used_by = used_by_count
  end

  def repositories_not_found(gem_name, message)
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
    raise(GetGemDataFromGitException, 'permission denied') if @api_response.include?('message')
    raise(GetGemDataFromGitException, 'not found') if @api_response.to_hash['items'].empty?

    symbolize @api_response.to_hash['items'].first
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
