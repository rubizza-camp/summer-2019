# enjoy
# rubocop:disable Performance/StringReplacement
require 'httparty'
require 'optparse'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'

class TopGems
  options = {}
  options[:file_name] = 'gems.yaml'

  OptionParser.new do |opt|
    opt.on('--top NUMBER') { |opa| options[:number] = opa }
    opt.on('--name EXCERPT') { |opa| options[:exp] = opa }
    opt.on('--file FILE') { |opa| options[:file_name] = opa }
  end.parse!

  # read file
  names = []
  filename = options[:file_name]
  file_content = File.open filename
  file_content.each do |line|
    names.push line.gsub(' - ', '').gsub("\n", '')
  end

  file_content.close

  names.shift

  main_arr = []
  names.each do |name_id|
    response = HTTParty.get("https://api.github.com/search/repositories?q=#{name_id}")
    git_api = response['items'].first
    array = []

    array << name_id

    nokogiri_object = Nokogiri::HTML(URI.open("#{git_api['html_url']}/network/dependents"))
    tagcloud_elements = nokogiri_object.css('div.table-list-header-toggle > a.btn-link')
    array << tagcloud_elements.first.text.gsub(',', '').to_i # used by

    nokogiri_object = Nokogiri::HTML(URI.open(git_api['html_url']))
    tagcloud_elements = nokogiri_object.css('ul.pagehead-actions > li > a.social-count')
    array << tagcloud_elements.first.text.gsub(',', '').to_i # watch

    array << git_api['watchers'] # stars

    array << git_api['forks'] # forks

    tagcloud_elements = nokogiri_object.css('ul.numbers-summary > li > a > span.num')
    array << tagcloud_elements.last.text.gsub(',', '').to_i # contributors

    array << git_api['open_issues_count'] # issuses

    main_arr << array
  end

  main_arr.sort! { |first, sekond| sekond[1] <=> first[1] } # sort array by parameter "used by"

  exp = options[:exp] # deleting gems that not include name
  if !exp.nil? # rubocop:disable Style/NegatedIf
    main_arr.each do |temporary_array|
      temporary_array.pop(7) if temporary_array[0].include?(exp) == false
    end
  end

  main_arr.delete([]).inspect
  main_arr.each do |temporary_array|
    temporary_array[1] = 'used by ' + temporary_array[1].to_s
    temporary_array[2] = 'watched by ' + temporary_array[2].to_s
    temporary_array[3] = temporary_array[3].to_s + ' stars'
    temporary_array[4] = temporary_array[4].to_s + ' forks'
    temporary_array[5] = temporary_array[5].to_s + ' contributors'
    temporary_array[6] = temporary_array[6].to_s + ' issues'
  end

  num = options[:number] # display top of some number
  if !num.nil? && !num.empty?
    puts num.inspect
    table = Terminal::Table.new rows: main_arr[0...num.to_i]
  else
    table = Terminal::Table.new rows: main_arr
  end
  puts table
end
# rubocop:enable Performance/StringReplacement
