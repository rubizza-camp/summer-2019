require 'yaml'
require 'rubygems'
require 'gems'
require 'open-uri'
require 'nokogiri'
require 'terminal-table'

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

  def <=>(other)
    popularity <=> other.popularity
  end
end

class ReaderYaml
  def self.call(file_name, option_name = '')
    gems = YAML.safe_load(File.open(file_name))['gems']
    gems = gems.select { |gem| gem.include? option_name } unless option_name == ''
    gems
  end
end

class ParserGemInfo
  def receive_info(page, element, number_element)
    page.css(element)[number_element].text.gsub(/[^0-9]/, '').to_i
  end

  def parse_gem_info(main_page, other_page)
    {
      users_count: receive_info(other_page, '.btn-link', 1),
      watcher_count: receive_info(main_page, '.social-count', 0),
      stars_count: receive_info(main_page, '.social-count', 1),
      forks_count: receive_info(main_page, '.social-count', 2),
      contributors_count: receive_info(main_page, '.text-emphasized', 0),
      issues_count: receive_info(main_page, '.Counter', 0)
    }
  end

  def parse_by(gem_name)
    link_main = Gems.info(gem_name)['source_code_uri']
    link_over = link_main + '/network/dependents'
    main_page = Nokogiri::HTML(Kernel.open(link_main))
    other_page = Nokogiri::HTML(Kernel.open(link_over))
    gem_info = parse_gem_info(main_page, other_page)
    gem_info[:name] = gem_name
    gem_info
  end

  def call(gem_name)
    gem_info = parse_by(gem_name)
    GemInfo.new(gem_info)
  end
end

class GemsViewer
  def call(gems)
    table_info = gems.map { |gem_info| gem_to_row(gem_info) }
    table_to_view = Terminal::Table.new rows: table_info
    puts table_to_view
  end

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
  def initialize
    @options = load_options
    @file_name = @options.key?('--file') ? @options['--file'] : 'gems.yaml'
    @option_name = @options.key?('--name') ? @options['--name'] : ''
  end

  def load_options
    options = {}
    ARGV.each do |option|
      option = option.split('=')
      options[option[0]] = option[1] if option.size == 2
    end
    options
  end

  def prepare_gems(gems)
    gems.sort!.reverse!
    number_of_line = @options['--top'].to_i
    gems = gems.first(number_of_line) if number_of_line > 0
    gems
  end

  def receive
    gems_name = ReaderYaml.call(@file_name, @option_name)
    parser_gem_info = ParserGemInfo.new
    gems = gems_name.map { |gem_name| parser_gem_info.call(gem_name) }
    prepare_gems(gems)
    GemsViewer.new.call(gems)
  #rescue StandardError => error
    #p error.message
  end
end

GemsPopularity.new.receive
