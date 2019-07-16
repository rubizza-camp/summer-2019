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

class Parse
  attr_accessor :arr, :gem_parameters

  def initialize
    @arr = []
    @gem_parameters = []
  end

  def yml_gems
    yml_gem_list = YAML.load_file('gems.yml')
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
        next if hash[:source] == nil
        
        page = agent.get(hash[:source])
        html = Nokogiri::HTML(page.content.toutf8)
        data = xpath_html(html)
        add_data_to_gem_parameters(data.unshift(hash[:gem_name]))
      end
    end
    threads.each(&:join)
  end

  private

  def authorization
    username = get_data_from_console("username")
    password = get_data_from_console("password")

    agent = Mechanize.new
    agent.get('https://github.com/login')
    agent.page.forms[0]['login'] = username
    agent.page.forms[0]['password'] = password
    agent.page.forms[0].submit

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

  def add_data_to_gem_parameters(data)
    @gem_parameters << {
      gem_name: data[0],
      used_by: data[1],
      watchers_count: data[2],
      stargazers_count: data[3],
      forks_count: data[4],
      contributors: data[5],
      open_issues_count: data[6]
    }
  end

  public

  def console_output
    table = Terminal::Table.new headings: ['Gem', 'Used by', 'Watched by', 'Stars',
                                           'Forks', 'Contributors', 'Issues'], rows: @gem_parameters
    puts table
  end
end

parser = Parse.new
parser.yml_gems
parser.link_parse
parser.console_output
