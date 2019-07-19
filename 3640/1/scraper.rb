require 'gems'
require 'octokit'
require 'nokogiri'
require 'terminal-table'
require 'optparse'

class Scraper
  def self.fetch_gem_parameters(gems_names)
    fetcher = new(gems_names)
    token = fetcher.access_token
    client = fetcher.build_client(token)
    fetcher.all_gems_info(client)
    fetcher.all_gems
  end

  attr_reader :gem_parameters, :all_gems

  def initialize(gems_names)
    @gems_names = gems_names
    @gem_parameters_key_value = { star: :stargazers_count, forks: :forks_count,
                                  issues: :open_issues_count, watch: :subscribers_count }
    @gem_parameters = {}
  end

  def build_client(token)
    begin
      client = Octokit::Client.new(access_token: token)
      client.user.login
    rescue Octokit::Unauthorized
      raise 'Please enter valid Personal Auth Token'
    end
    client
  end

  def access_token
    puts 'Enter your Github Personal Access Token:'
    gets.chomp
  end

  def all_gems_info(client)
    @all_gems = @gems_names.map do |name_gem|
      parameters = gem_info(name_gem, client)
      parameters ? GemOne.new(name_gem, @gem_parameters) : (puts "invalid gem: '#{name_gem}'")
    end
    all_gems.compact!
  end

  private

  def gem_info_source_code(gem)
    Gems.info(gem)['source_code_uri']
  end

  def gem_info_homepage(gem)
    Gems.info(gem)['homepage_uri']
  end

  def gem_info(gem, client)
    path = gem_info_source_code(gem) || gem_info_homepage(gem)
    fetch_gem_properties(path, client) if path
  end

  def fetch_gem_properties(path, client)
    path.sub!(%r{http.*com/}, '')
    repo = repository(path, client)
    gem_properties(repo, contributors_count(path), used_by_count(path))
  end

  def contributors_count(path)
    contributors(path).css('span.num.text-emphasized').children[2].text
  end

  def used_by_count(path)
    dependents(path).css('.btn-link')[1].text.delete('^0-9')
  end

  def contributors(path)
    Nokogiri::HTML(open("https://github.com/#{path}"))
  end

  def dependents(path)
    Nokogiri::HTML(open("https://github.com/#{path}/network/dependents"))
  end

  def repository(path, client)
    client.repo path
  end

  def gem_properties(repo, contributors_count, used_by_count)
    @gem_parameters_key_value.each { |key, value| gem_parameters[key] = repo[value].to_i }
    @gem_parameters[:contributors] = contributors_count.to_i
    @gem_parameters[:used_by] = used_by_count.to_i
  end
end
