require 'yaml'
require 'json'
require 'terminal-table'
require './Models/Gems.rb'
require 'net/http'
require 'uri'
require 'nokogiri'
require 'open-uri'

def parse_yml_file
  file = YAML.load_file("gems.yml")
  file['gems']
end

def find_repo_html_url(name)
begin
  uri = URI.parse("https://api.github.com/search/repositories?q=#{name}&sort=stars&order=desc")
  a = response_body_hash(uri)
  b = a[:items]
  c = b[0]
  d= c[:html_url]
  # sleep(1)
  rescue NoMethodError
  require'pry';binding.pry;
end
end

def find_fields(url)
  result = []
  doc = Nokogiri::HTML(open(url))
  doc.css('.social-count').each do |a|
    result.push (a.content.gsub(/[^0-9]/, '').to_i)
  end
  result.push(doc.css('.Counter')[0].content.gsub(/[^0-9]/, '').to_i)
  result.push(doc.css('.num').css('.text-emphasized')[3].text.gsub(/[^0-9]/, ''))
end

def find_used_by(url)
  url+= "/network/dependents"
  doc = Nokogiri::HTML(open(url))
  doc.css('.btn-link').css('.selected').text.gsub(/[^0-9]/, '')
end

def response_body_hash url
  Net::HTTP.start(url.host, url.port,
  :use_ssl => url.scheme == 'https') do |http|
    request = Net::HTTP::Get.new url
    response = http.request(request)
    return JSON.parse(response.body, symbolize_names: true)
  end
end

def show_table(args)
  arr = []
  args.each { |i| arr.push(i[0].get_fields) }
  table = Terminal::Table.new do |t|
    t.rows = arr
    t.style = { :border_top => false, :border_bottom => false }
  end
  puts table
end

def pars_gems()
  begin
    array= []
    parsed_file = parse_yml_file
    complited = 0
    print "Complited status #{complited}/#{parsed_file.count}"
    parsed_file.each do |gem| 
      complited += 1
      print "\rComplited status----------------------------------------------------------------#{complited}/#{parsed_file.count}"
      print "\n" if complited == parsed_file.count
      # require 'pry'; binding.pry;
      gem_object = Gems.new(gem)
      gem_object.url = find_repo_html_url(gem)
      gem_object.set_fields(find_fields(gem_object.url))
      gem_object.count_used_by = find_used_by(gem_object.url)
      array.push(gem_object)
    end
    array
    # show_table(array.each_slice(1).to_a)
    rescue :NoMethodErrors 
    require 'pry';binding.pry
  end
end

def choose_top_gem(gems)
  p gems
end

def main()
  # require 'pry'; binding.pry;
  ARGV.each do |argumet|
    case argumet
      when /--top/
      argumet.split('=')[1]
      choose_top_gem(pars_gems) 
    end
  end
  # array= []
  # parsed_file = parse_yml_file
  # complited = 0
  # print "Complited status #{complited}/#{parsed_file.count}"
  # parsed_file.each do |gem| 
  #   complited += 1
  #   print "\rComplited status----------------------------------------------------------------#{complited}/#{parsed_file.count}"
  #   print "\n" if complited == parsed_file.count
  #   gem_object = Gems.new(gem)
  #   gem_object.url = find_repo_html_url(gem)
  #   gem_object.set_fields(find_fields(gem_object.url))
  #   gem_object.count_used_by = find_used_by(gem_object.url)
  #   array.push(gem_object)
  # end
  # show_table(array.each_slice(1).to_a)
end

main