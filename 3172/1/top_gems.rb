require 'yaml'
require 'rubygems'
require 'gems'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'

# :reek:TooManyInstanceVariables
class GemInfo
  attr_reader :name,
              :users_count,
              :watcher_count,
              :stars_count,
              :forks_count,
              :contributors_count,
              :issues_count,
              :popularity

  def initialize(params)
    @name = params[:name]
    @users_count = params[:users_count]
    @watcher_count = params[:watcher_count]
    @stars_count = params[:stars_count]
    @forks_count = params[:forks_count]
    @contributors_count = params[:contributors_count]
    @issues_count = params[:issues_count]

    @popularity = calculate_popularity
  end

  def <=>(other)
    popularity <=> other.popularity
  end

  private

  def calculate_popularity
    [
      users_count,
      watcher_count * 550,
      stars_count * 25,
      forks_count * 40,
      contributors_count * 100,
      issues_count * 1000
    ].sum / 1000
  end
end

class ReadYaml
  def self.call(file_name, option_name = nil)
    gems = YAML.safe_load(File.open(file_name))['gems']
    gems.select! { |gem| gem.include? option_name } if option_name
    gems
  end
end

class ParseGemInfo
  def call(gem_name)
    gem_info = parse_by(gem_name)
    gem_info = create_empty_gem_info(gem_name) if gem_info == 'bad'
    GemInfo.new(gem_info)
  end

  private

  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def parse_by(gem_name)
    gems_info_name = Gems.info(gem_name)
    link_main = gems_info_name['source_code_uri'] || gems_info_name['homepage_uri'] || ''
    return 'bad' unless link_main.include? '://github.com/'
    link_over = link_main + '/network/dependents'
    main_page = Nokogiri::HTML(Kernel.open(link_main))
    other_page = Nokogiri::HTML(Kernel.open(link_over))
    gem_info = parse_gem_info(main_page, other_page)
    gem_info[:name] = gem_name
    gem_info
  end

  # :reek:UtilityFunction
  def parse_gem_info(main_page, other_page)
    {
      users_count:        receive_info(other_page, '.btn-link',        1),
      watcher_count:      receive_info(main_page,  '.social-count',    0),
      stars_count:        receive_info(main_page,  '.social-count',    1),
      forks_count:        receive_info(main_page,  '.social-count',    2),
      contributors_count: receive_info(main_page,  '.text-emphasized', 0),
      issues_count:       receive_info(main_page,  '.Counter',         0)
    }
  end

  def create_empty_gem_info(gem_name)
    {
      users_count:        0,
      watcher_count:      0,
      stars_count:        0,
      forks_count:        0,
      contributors_count: 0,
      issues_count:       0,
      name:               gem_name
    }
  end

  # :reek:UtilityFunction
  def receive_info(page, element, number_element)
    page.css(element)[number_element].text.gsub(/\D/, '').to_i
  end
end

class GemsView
  def call(gems)
    table_info = gems.map { |gem_info| gem_to_row(gem_info) }
    table_to_view = Terminal::Table.new rows: table_info
    puts table_to_view
  end

  private

  # :reek:UtilityFunction
  def gem_to_row(gem_info)
    [
      gem_info.name,
      "used by #{gem_info.users_count}",
      "watched by #{gem_info.watcher_count}",
      "#{gem_info.stars_count} stars",
      "#{gem_info.forks_count} forks",
      "#{gem_info.contributors_count} contributors",
      "#{gem_info.issues_count} issues",
      "#{gem_info.popularity} popularity"
    ]
  end
end

class GemsPopularity
  # :reek:FeatureEnvy
  def initialize
    options = load_options
    @file_name = options.key?('--file') ? options['--file'] : 'gems.yaml'
    @option_name = options['--name']
    @option_top = options['--top']
  end

  # :reek:TooManyStatements
  def receive
    gems_name = ReadYaml.call(@file_name, @option_name)
    parse_gem_info = ParseGemInfo.new
    gems = gems_name.map { |gem_name| parse_gem_info.call(gem_name) }
    gems = prepare_gems(gems)
    GemsView.new.call(gems)
  end

  private

  def load_options
    ARGV.each_with_object({}) do |item, options|
      key, value = item.split('=')
      options[key] = value
    end
  end

  # :reek:TooManyStatements
  # :reek:FeatureEnvy
  def prepare_gems(gems)
    gems.sort!.reverse!
    gems = gems.first(@option_top.to_i) if @option_top
    gems
  end
end

GemsPopularity.new.receive
