require 'gems'
require 'octokit'
require 'nokogiri'
require 'terminal-table'
require 'optparse'
# :reek:InstanceVariableAssumption
# :reek:TooManyStatements
class Scraper
  GEM_PARAMETERS_KEY_VALUE = { star: :stargazers_count,
                               forks: :forks_count,
                               issues: :open_issues_count,
                               watch: :subscribers_count }.freeze

  HAS_NO_GEM = 'github.com has no gem: '.freeze
  ENTER_VALID_TOKEN = 'Please enter valid Personal Auth Token'.freeze
  ENTER_PERSONAL_TOKEN = 'Enter your Github Personal Access Token:'.freeze

  def self.fetch_gem_parameters(gems_names)
    fetcher = new
    fetcher.client_login
    fetcher.all_gems_info(gems_names)
    fetcher.all_gems
  end

  attr_reader :all_gems

  def client
    @client ||= fetch_client
  end

  def fetch_client
    Octokit::Client.new(access_token: token)
  end

  def parse_error
    puts ENTER_VALID_TOKEN
    fetch_client
    @client = fetch_client
    client_login
  end

  def client_login
    client.user.login
  rescue Octokit::Unauthorized
    parse_error
  end

  def token
    puts ENTER_PERSONAL_TOKEN
    gets.chomp
  end

  def all_gems_info(gems_names)
    @all_gems = gems_names.map do |name_gem|
      gem_info(name_gem) ? GemResource.new(name_gem, @gem_parameters) : puts(HAS_NO_GEM + name_gem)
    end
    all_gems.compact!
  end

  private

  def gem_info_source_code_homepage(gem)
    Gems.info(gem)['source_code_uri'] || Gems.info(gem)['homepage_uri']
  end

  def gem_info(gem)
    @path = gem_info_source_code_homepage(gem)
    fetch_gem_properties if @path.include?('://github.com')
  end

  def fetch_gem_properties
    @path.sub!(%r{http.*com/}, '')
    repo = repository
    gem_properties(repo)
  end

  def contributors_count
    contributors.css('span.num.text-emphasized').children[2].text
  end

  def used_by_count
    dependents.css('.btn-link')[1].text.delete('^0-9')
  end

  def contributors
    Nokogiri::HTML(open("https://github.com/#{@path}"))
  end

  def dependents
    Nokogiri::HTML(open("https://github.com/#{@path}/network/dependents"))
  end

  def repository
    client.repo(@path)
  end

  def gem_properties(repo)
    @gem_parameters = {}
    GEM_PARAMETERS_KEY_VALUE.each { |key, value| @gem_parameters[key] = repo[value].to_i }
    @gem_parameters[:contributors] = contributors_count.to_i
    @gem_parameters[:used_by] = used_by_count.to_i
    @gem_parameters
  end
end
