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

HEADERS = ['Gem', 'Used by', 'Watched by', 'Stars', 'Forks', 'Contributors', 'Issues'].freeze
LOGIN_URL = 'https://github.com/login'
DEFAULT_FILE = 'gems.yml'

class Parse
  attr_accessor :arr, :gem_parameters

  def initialize
    @arr = []
    @gem_parameters = []
    @params = ARGV.empty? ? [] : ARGV.first.split('=')
  end

  def yml_gems
    if @params[0] == '--file'
      yml_gem_list = YAML.load_file(@params[1])
    else
      yml_gem_list = YAML.load_file(DEFAULT_FILE)
    end
    yml_gem_list['gems'].each do |gem_name|
      gem_info = Gems.info(gem_name)
      gem_request = {
        gem_name: gem_name,
        homepage: gem_info['homepage_uri']&.gsub('http:', 'https:'),
        source: gem_info['source_code_uri']&.gsub('http:', 'https:')
      }
      @arr << gem_request
    end
  end

  def link_parse
    agent = authorization

    threads = []
    @arr.each do |hash|
      threads << Thread.new do
        hash[:source] = hash[:homepage] if hash[:source] == nil || hash[:source] == ''

        page = agent.get(hash[:source])
        html = Nokogiri::HTML(page.content.toutf8)
        data = xpath_html(html)
        @gem_parameters << data.unshift(hash[:gem_name])
      end
    end
    threads.each(&:join)
  end

  def sort
    popularization_sort
    case @params[0]
    when '--top'
      @gem_parameters = @gem_parameters[0..@params[1]]
    when '--name'
      @gem_parameters = @gem_parameters.map { |element| element[0].include?(@params[1]) ? element : nil }.compact
    end
  end

  def console_output
    table = Terminal::Table.new headings: HEADERS, rows: @gem_parameters
    puts table
  end

  private

  def authorization
    agent = Mechanize.new
    agent.get(LOGIN_URL)
    result = nil
    loop do
      puts "Wrong username or password, please ty again" if result
      agent.page.forms[0]['login'] =  get_data_from_console("username")
      agent.page.forms[0]['password'] = get_data_from_console("password")
      result = agent.page.forms[0].submit
      break if result.title.eql?('GitHub')
    end

    agent
  end

  def get_data_from_console(text)
    puts "Write #{text}"
    STDIN.noecho(&:gets).chomp
  end

  def get_social_info(html)
    data = html.xpath("//a[starts-with(@class, 'social-count')]")
    data.map {|d| d.text.delete('^0-9').to_i }.uniq
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

  def popularization_sort
    @gem_parameters.sort_by! do |element|
      element[3] * 2 + element[4] * 2 + element[2] + element[1] - element[6] * 1000
    end.reverse!
  end
end

parser = Parse.new
parser.yml_gems
parser.link_parse
parser.sort
parser.console_output
