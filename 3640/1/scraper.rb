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

  def self.fetch_gem_parameters(gems_names)
    fetcher = new
    fetcher.client_login
    fetcher.all_gems_info(gems_names)
  end

  attr_reader :all_gems

  def client
    @client ||= fetch_client
  end

  def fetch_client
    Octokit::Client.new(access_token: token)
  end

  def parse_error
    puts 'Please enter valid Personal Auth Token'
    @client = fetch_client
    client_login
  end

  def client_login
    client.user.login
  rescue Octokit::Unauthorized
    parse_error
  end

  def token
    puts 'Enter your Github Personal Access Token:'
    gets.chomp
  end

  def all_gems_info(gems_names)
    @all_gems = gems_names.map do |name_gem|
      if gem_info(name_gem)
        GemResource.new(name_gem, @gem_parameters)
      else
        puts('github.com has no gem: ' + name_gem)
      end
    end
    all_gems.compact!
  end

  private

  def gem_info_source_code_homepage(gem)
    Gems.info(gem)['source_code_uri'] || Gems.info(gem)['homepage_uri']
  end

  def gem_info(gem)
    @path = gem_info_source_code_homepage(gem)
    return nil unless @path.include?('://github.com')
    @path.sub!(%r{http.*com/}, '')
    search_gem_parameters(repository)
  end

  def contributors_count
    contributors.css('span.num.text-emphasized').children[2].text.to_i
  end

  def used_by_count
    dependents.css('.btn-link')[1].text.delete('^0-9').to_i
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

  def search_gem_parameters(repository)
    @gem_parameters = {}
    GEM_PARAMETERS_KEY_VALUE.each { |key, value| @gem_parameters[key] = repository[value].to_i }
    @gem_parameters[:contributors] = contributors_count
    @gem_parameters[:used_by] = used_by_count
    @gem_parameters
  end
end
