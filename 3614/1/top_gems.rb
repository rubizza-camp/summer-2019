require 'yaml'
require 'gems'
require 'pry'
require 'net/http'
require 'json'

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
        watchers_count: gem_data['watchers_count'],
        stargazers_count: gem_data['stargazers_count'],
        forks_count: gem_data['forks_count'],
        open_issues_count: gem_data['open_issues_count']
        }     
    end
    puts @gem_parameters
  end
  # def uri_check

  # end
end

parser = Parse.new
parser.yml_gems
parser.link_parse


# attr_accessor :parse_page

#   def initialize
#     doc = HTTParty.get(https://rubygems.org/gems/"#{yml_gems}")
#     @parse_page ||= Nokogiri::HTML(doc)
#   end
#   values += 1
# end

# end






# yaml_data = YAML.load_file('gems.yml')
# p yaml_data.values

# gems_info = Gems.info 'rails'
# p gems_info

# page = Nokogiri::HTML(open("http://en.wikipedia.org/"))   
# puts page.class   # => Nokogiri::HTML::Document
# end



# yml_gem_list = YAML.load_file('gems.yml')
#     yml_gem_list['gems'].each do |gem_name|
#       url = 'https://rubygems.org/gems/' + gem_name
#       puts url
#     end