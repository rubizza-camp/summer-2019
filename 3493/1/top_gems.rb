require 'yaml'
require 'json'
require 'terminal-table'
require './Models/gem_model.rb'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'

class GemManager
  attr_reader :gem_hash 

  def initialize
    @gem_hash = {}
  end

  def parse_yml_file(file_name)
    file = YAML.load_file(file_name)
    file['gems']
  end

  def find_repo_html_url(name)
    begin
      uri = URI.parse("https://api.github.com/search/repositories?q=#{name}&sort=stars&order=desc")
      response_body_hash(uri)[:items][0][:html_url] 
    end
  end

  def response_body_hash(url)
    Net::HTTP.start(url.host, url.port,
    :use_ssl => url.scheme == 'https') do |http|
      request = Net::HTTP::Get.new(url)
      response = http.request(request)
      return JSON.parse(response.body, symbolize_names: true)
    end
  end  

  def find_fields(url)
    result = []
    doc = Nokogiri::HTML(open(url))
    doc.css('.social-count').each do |a|
      result.push (a.content.gsub(/[^0-9]/, ''))
    end
    result.push(doc.css('.Counter')[0].content.gsub(/[^0-9]/, ''))
    result.push(doc.css('.num').css('.text-emphasized')[3].text.gsub(/[^0-9]/, ''))
  end  

  def find_used_by(url)
    url+= "/network/dependents"
    doc = Nokogiri::HTML(open(url))
    doc.css('.btn-link').css('.selected').text.gsub(/[^0-9]/, '')
  end
  
  def show_table
    rows = []
    @gem_hash.each { |key, value| rows << value.strings }
    table = Terminal::Table.new do |t|
      t.rows = rows
      t.style = { :border_top => false, :border_bottom => false }
    end
    puts table
  end
  
  def parse_gem(file_name:"gems.yml", name_gems:nil)
    parsed_yml_file = parse_yml_file(file_name) 
    threads = []
    parsed_yml_file.each do |gem| 
        if gem.match(/#{name_gems}/) 
          threads << Thread.new do
            gem_object = GemModel.new(gem)
            gem_object.url = find_repo_html_url(gem)
            gem_object.install_fields(find_fields(gem_object.url))
            gem_object.count_used_by = find_used_by(gem_object.url)
            @gem_hash[gem] = gem_object
          end
        end
    end
    threads.each(&:join)
  end

  def choose_top_gem(top_count)
    score = {}
    hash = {}
    gem_hash.each do |key, value|
      array = value.fields
      score[array[0]] = 3 * array[1] + 1 * array[2] + 2 * array[3] +
                        2 * array[4] + 1 * array[5] + 2 * array[6]
    end
    score = score.sort_by{|key, value| value}.last(top_count.to_i)
    score.each{ |elem| hash[elem[0]] = @gem_hash[elem[0]] }
    @gem_hash = hash
  end 

end






def main()
  gem_manager = GemManager.new
  setting = {}
  ARGV.each do |argumet|
    case argumet
      when /--top/
        string_fields = argumet.split('=')
        setting[string_fields[0]] = string_fields[1] 
      when /--name/
        string_fields = argumet.split('=')
        setting[string_fields[0]] = string_fields[1]
      when /--file/
        string_fields = argumet.split('=')
        setting[string_fields[0]] = string_fields[1]
      else 
        puts 'Argument Error'  
    end
  end
  setting.each do |key, value| 
    case key
      when '--top'
        gem_manager.parse_gem
        gem_manager.choose_top_gem(value) 
        gem_manager.show_table
      when '--name'
        # binding.pry
        gem_manager.parse_gem(name_gems: value)
        gem_manager.show_table
      when '--file'
        gem_manager.parse_gem(file_name:value)
        gem_manager.show_table
    end
  end
  # p setting
  # parse()
end

main