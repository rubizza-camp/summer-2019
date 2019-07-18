require 'gems'
require 'octokit'
require 'nokogiri'
require 'terminal-table'
require 'optparse'
# :reek:TooManyStatements
# :reek:UtilityFunction
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
  end

  def build_client(token)
    begin
      client = Octokit::Client.new(access_token: token)
      client.user.login
    rescue Octokit::Unauthorized
      raise %(Please enter valid Personal Auth Token)
    end
    client
  end

  def access_token
    puts %(Enter your Github Personal Access Token:)
    gets.chomp
  end

  def all_gems_info(client)
    @all_gems = @gems_names.map do |name_gem|
      parameters = gem_info(name_gem, client)
      GemOne.new(name_gem, parameters)
    end
  end

  private

  def gem_info_source_code(gem)
    Gems.info(gem)['source_code_uri']
  end

  def gem_info_homepage(gem)
    Gems.info(gem)['homepage_uri']
  end

  def gem_info(gem, client)
    begin
      uri = (gem_info_source_code(gem) || gem_info_homepage(gem)).sub!(%r{http.*com/}, '')
      repo = repository(uri, client)
    rescue NoMethodError
      raise %(Invalid gem in file gems.yaml)
    end
    gem_properties(repo, contributors_count(uri), used_by_count(uri))
  end

  def contributors_count(uri)
    contributors(uri).css('span.num.text-emphasized').children[2].text.to_i
  end

  def used_by_count(uri)
    dependents(uri).css('.btn-link')[1].text.delete('^0-9').to_i
  end

  def contributors(uri)
    Nokogiri::HTML(open("https://github.com/#{uri}"))
  end

  def dependents(uri)
    Nokogiri::HTML(open("https://github.com/#{uri}/network/dependents"))
  end

  def repository(uri, client)
    client.repo uri
  end

  def gem_properties(repo, contributors_count, used_by_count)
    gem_parameters = {}
    gem_parameters[:star] = repo[:stargazers_count].to_i
    gem_parameters[:forks] = repo[:forks_count].to_i
    gem_parameters[:issues] = repo[:open_issues_count].to_i
    gem_parameters[:watch] = repo[:subscribers_count].to_i
    gem_parameters[:contributors] = contributors_count.to_i
    gem_parameters[:used_by] = used_by_count.to_i
    gem_parameters
  end
end
