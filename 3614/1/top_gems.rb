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

  def auth
    @agent.get(LOGIN_URL)

    loop do
      result = set_form
      break if result.title.eql?('GitHub')

      puts 'Wrong username or password, please ty again'
    end
  end

  def parse_gem_data
    threads = []
    @gems_data.each do |gem_data|
      threads << Thread.new do
        link_parse(gem_data)
      end
    end
    threads.each(&:join)
  end

  def sort
    @gems_stat.sort_by! { |gem_stat| gem_stat[1] - gem_stat[6] * 1000 }.reverse!

    sort_by_params
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

    return info['homepage_uri'] unless source

    source
  end

  def get_data_from_console(text)
    puts "Write #{text}"
    STDIN.noecho(&:gets).chomp
  end

  def set_form
    form = @agent.page.forms[0]
    form['login'] =  get_data_from_console('username')
    form['password'] = get_data_from_console('password')
    form.submit
  end

  def get_social_info(html)
    data = html.xpath("//a[starts-with(@class, 'social-count')]")
    data.map! { |info| info.text.delete('^0-9').to_i }.uniq!
  end

  def get_contributors(html)
    data = html.xpath("//ul[@class='numbers-summary']/li/a/span").last
    data.text.delete('^0-9').to_i
  end

  def xpath_html(html)
    social_info = get_social_info(html)
    contributors = get_contributors(html)
    open_issues = html.xpath("//span[@class='Counter']")[0].text.to_i

    social_info << contributors << open_issues
  end

  def link_parse(gem_data)
    page = @agent.get(gem_data[:source])
    html = Nokogiri::HTML(page.content.toutf8)
    data = xpath_html(html)
    @gems_stat << data.unshift(gem_data[:gem_name])
  end

  def sort_by_key
    key, value = @params

    case key
    when '--top'
      @gems_stat = @gems_stat[0..value.to_i]
    when '--name'
      @gems_stat = @gems_stat.map do |gem_stat|
        gem_stat[0].include?(value) ? gem_stat : nil
      end.compact
    end
  end
end

parser = Parse.new
parser.yml_gems
parser.auth
parser.parse_gem_data
parser.sort
parser.console_output
