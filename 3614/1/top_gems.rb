# frozen_string_literal: true

require 'yaml'
require 'gems'
require 'pry'
require 'net/http'
require 'json'
require 'nokogiri'
require 'mechanize'
require 'open-uri'
require 'io/console'
require 'terminal-table'

HEADERS = [
  'Gem',
  'Used by',
  'Watched by',
  'Stars',
  'Forks',
  'Contributors',
  'Issues'
].freeze

LOGIN_URL = 'https://github.com/login'
DEFAULT_FILE = 'gems.yml'

class Parse
  attr_reader :gems_data, :gems_stat

  def initialize
    @gems_data = []
    @gems_stat = []
    @params = ARGV.empty? ? [] : ARGV.first.split('=')
    @agent = Mechanize.new
  end

  def yml_gems
    yml_gem_list = take_gem_list

    yml_gem_list['gems'].each do |gem_name|
      gem_info = Gems.info(gem_name)

      @gems_data << {
        gem_name: gem_name,
        source: source_set(gem_info)
      }
    end
  end

  def pars_data
    auth

    threads = []
    @gems_data.each do |gem_data|
      threads << Thread.new do
        link_parse(gem_data)
      end
    end
    threads.each(&:join)
  end

  def sort
    # stat_sort
    case @params[0]
    when '--top'
      @gems_stat = @gems_stat[0..@params[1].to_i]
    when '--name'
      @gems_stat = @gems_stat.map do |gem_stat|
        gem_stat[0].include?(@params[1]) ? gem_stat : nil
      end.compact
    end
  end

  def console_output
    table = Terminal::Table.new headings: HEADERS, rows: @gems_stat
    puts table
  end

  private

  def take_gem_list
    return YAML.load_file(@params[1]) if @params[0] == '--file'

    YAML.load_file(DEFAULT_FILE)
  end

  def source_set(info)
    source = info['source_code_uri']

    return info['homepage_uri'] if source.nil?

    source
  end

  def get_data_from_console(text)
    puts "Write #{text}"
    STDIN.noecho(&:gets).chomp
  end

  def set_form
    @agent.page.forms[0]['login'] =  get_data_from_console('username')
    @agent.page.forms[0]['password'] = get_data_from_console('password')
    @agent.page.forms[0].submit
  end

  def auth
    @agent.get(LOGIN_URL)
    result = nil
    loop do
      puts 'Wrong username or password, please ty again' if result
      result = set_form
      break if result.title.eql?('GitHub')
    end
  end

  def get_social_info(html)
    data = html.xpath("//a[starts-with(@class, 'social-count')]")
    data.map { |d| d.text.delete('^0-9').to_i }.uniq
  end

  def get_contributors(html)
    data = html.xpath("//ul[@class='numbers-summary']/li/a/span").last
    data.text.delete('^0-9').to_i
  end

  def get_open_issues(html)
    html.xpath("//span[@class='Counter']")[0].text.to_i
  end

  def xpath_html(html)
    result = get_social_info(html)
    result.push(get_contributors(html))
    result.push(get_open_issues(html))

    result
  end

  def link_parse(gem_data)
    page = @agent.get(gem_data[:source])
    html = Nokogiri::HTML(page.content.toutf8)
    data = xpath_html(html)
    @gems_stat << data.unshift(gem_data[:gem_name])
  end

  def stat_sort
    @gems_stat.sort_by! do |gem_stat|
      gem_stat[3] * 10 + gem_stat[4] * 5 + gem_stat[1] - gem_stat[6] * 1000
    end.reverse!
  end
end

parser = Parse.new
parser.yml_gems
parser.pars_data
parser.sort
parser.console_output
