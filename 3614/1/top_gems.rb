require 'yaml'
require 'gems'
require 'pry'
require 'net/http'
require 'json'
require 'nokogiri'
require 'open-uri'

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
        homepage: gem_info['homepage_uri']&.gsub('http:', 'https:'),
        source: gem_info['source_code_uri']&.gsub('http:', 'https:')
      }
      @arr << gem_request
    end
  end

  def link_parse
    @arr.each do |hash|
      if hash[:source] == nil
        next
      end
      link = hash[:source].gsub('https://github.com/', '')
      response = Net::HTTP.get(URI("https://api.github.com/repos/" + "#{link}"))
      gem_data = JSON.parse(response)
      @gem_parameters << {
        used_by: [nil],
        watchers_count: gem_data['watchers_count'],
        stargazers_count: gem_data['stargazers_count'],
        forks_count: gem_data['forks_count'],
        contributors: [nil],
        open_issues_count: gem_data['open_issues_count']
        

        }     
    end
  end
  
  def  acquisition_data(gem_name, github_link)
    parsed_github_html = Nokogiri::HTML(URI.parse(github_link + '/contributors_size').open)
    contributors = parsed_github_html.css('span').text.delete('^0-9').to_i

    parsed_github_html = Nokogiri::HTML(URI.parse(github_link + '/network/dependents').open)
    used_by = parsed_github_html.css('div.table-list-header-toggle a')[0].text.delete('^0-9').to_i

    @gems_parameters << [used_by, contributors]
  end

  #


  def sorting(data)
    @gem_parameters = data
    return sorted_data = data.sort! { |a, b| b[1] <=> a[1] }
  end

  def rewrite_final_array(array)
    @arr = array
  end

  def console_output
    table = Terminal::Table.new :headings => ['Gem', 'Used by', 'Watched by', 'Stars', 'Forks', 'Contributors', 'Issues'], :rows => @arr
    puts table
  end
  #
end

parser = Parse.new
parser.yml_gems
parser.link_parse

