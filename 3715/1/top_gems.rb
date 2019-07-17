require 'optparse'
require 'yaml'
require 'open-uri'
require 'json'
require 'nokogiri'
require 'terminal-table'

GITHUB_REPOSITORIES_API_URL = 'https://api.github.com/search/repositories?q='.freeze
GITHUB_NETWORK_DEPENDENTS = '/network/dependents'.freeze

# File interaction
class Files
  def name_gem(file = 'gems.yml')
    YAML.load_file(file)['gems']
  rescue Errno::ENOENT
    puts "'#{file}': The file is missing or has an incorrect name."
    exit
  rescue Psych::SyntaxError
    puts ["'#{file}': YAML parsing error.",
          'There may be a problem with the contents of the file.']
    exit
  end
end

# Scraping info about gems from github
class GitHubRepositoryParser
  attr_reader :name_gem

  def initialize(name_gem)
    @name_gem = name_gem
  end

  def github_api
    JSON.parse(URI.open(GITHUB_REPOSITORIES_API_URL + name_gem).read)['items'].first
  end

  def github_repository_title
    github_parse(github_api['html_url'])
  end

  def github_network_dependents
    github_parse(github_api['html_url'] + GITHUB_NETWORK_DEPENDENTS)
  end

  private

  def github_parse(page)
    Nokogiri::HTML(URI.open(page))
  end
end

# Collecting info about gem
class RubyGem
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def used_by
    page = GitHubRepositoryParser.new(name).github_network_dependents
    page.css('a.btn-link').first.text.delete(',').to_i
  end

  def watch
    GitHubRepositoryParser.new(name).github_repository_title.css('a.social-count').first.text.to_i
  end

  def star
    GitHubRepositoryParser.new(name).github_api['watchers']
  end

  def fork
    GitHubRepositoryParser.new(name).github_api['forks']
  end

  def contributors
    GitHubRepositoryParser.new(name).github_repository_title.css('span.num').last.text.to_i
  end

  def issues
    GitHubRepositoryParser.new(name).github_repository_title.css('span.Counter').first.text.to_i
  end
end

# Making a list of gems
class GemList
  def self.make_gemlist
    Files.new.name_gem.map { |title| RubyGem.new(title) }
  end
end

# Prepare gemlist for display
class TopRubyGems < GemList
  def self.pick_names(text)
    matched_name = make_gemlist.map do |ruby_gem|
      ruby_gem if ruby_gem.name.include?(text)
    end.compact!
    sort_gems(matched_name)
  end

  def self.top_gems
    sort_gems(make_gemlist)
  end

  def self.sort_gems(list)
    list.sort_by { |ruby_gem| - ruby_gem.star }
  end
end

# Configuration of the table with the results
class CreateTable
  HEADER = [
    'Title gem',
    'Depend on',
    'Are watching',
    'Has stars',
    'Has forks',
    'Has contributors',
    'Has issues'
  ].freeze

  def self.table(top_gems)
    {
      headings: HEADER,
      rows: top_gems.map(&method(:table_row)),
      style: { alignment: :center, all_separators: true }
    }
  end

  def self.table_row(ruby_gem)
    [
      ruby_gem.name,
      "used by #{ruby_gem.used_by}",
      "watched by #{ruby_gem.watch}",
      "#{ruby_gem.star} stars",
      "#{ruby_gem.fork} forks",
      "#{ruby_gem.contributors} contributors",
      "#{ruby_gem.issues} issues"
    ]
  end
end

def show_top(top)
  new_table = CreateTable.table(top)
  puts Terminal::Table.new(new_table)
end

(show_top(TopRubyGems.top_gems) if ARGV.empty?)
OptionParser.new do |options|
  options.on('-t', '--top NUMBER', Integer,
             'Top of Ruby gems from gems.yml file') do |max_num_gems|
    show_top(TopRubyGems.top_gems.first(max_num_gems))
  end

  options.on('-n', '--name NAME', String,
             'Shows all gems, whose name contains the specified word') do |text|
    show_top(TopRubyGems.pick_names(text))
  end

  options.on('-f', '--file FILE', String,
             'Specify gems.yml containing a list of gem names') do |file|
    another_name_gem = Files.new.name_gem(file)
    make_another_gemlist = another_name_gem.map { |title| RubyGem.new(title) }
    show_top(TopRubyGems.sort_gems(make_another_gemlist))
  end

  options.on('-h', '--help',
             'Use this option for more info') do
    puts options
    exit
  end
end.parse!
