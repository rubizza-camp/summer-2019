# enjoy

require 'httparty'
require 'optparse'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'

class Helpmeplease
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
  fh = File.open filename
  fh.each do |line|
    names.push line.gsub(' - ', '').gsub("\n", '')
  end

  fh.close

  names.shift

  uganda = []
  names.each do |name_id|
    response = HTTParty.get("https://api.github.com/search/repositories?q=#{name_id}")
    coco = response['items'].first
    do_u_wanna_de_way = []

    do_u_wanna_de_way << name_id

    nokogiri_object = Nokogiri::HTML(URI.open("#{coco['html_url']}/network/dependents"))
    tagcloud_elements = nokogiri_object.css('div.table-list-header-toggle > a.btn-link')
    do_u_wanna_de_way << tagcloud_elements.first.text.gsub(',', '').to_i # used by

    nokogiri_object = Nokogiri::HTML(URI.open(coco['html_url']))
    tagcloud_elements = nokogiri_object.css('ul.pagehead-actions > li > a.social-count')
    do_u_wanna_de_way << tagcloud_elements.first.text.gsub(',', '').to_i # watch

    do_u_wanna_de_way << coco['watchers'] # stars

    do_u_wanna_de_way << coco['forks'] # forks

    tagcloud_elements = nokogiri_object.css('ul.numbers-summary > li > a > span.num')
    do_u_wanna_de_way << tagcloud_elements.last.text.gsub(',', '').to_i # contributors

    do_u_wanna_de_way << coco['open_issues_count'] # issuses

    uganda << do_u_wanna_de_way
  end

  uganda.sort! { |aleluya, bob| bob[1] <=> aleluya[1] } # sort array by parameter "used by"

  exp = options[:exp] # deleting gems that not include name
  if !exp.nil? # rubocop:disable Style/NegatedIf
    uganda.each do |knok_knok|
      knok_knok.pop(7) if knok_knok[0].include?(exp) == false
    end
  end

  uganda.delete([]).inspect
  uganda.each do |knok_knok|
    knok_knok[1] = 'used by ' + knok_knok[1].to_s
    knok_knok[2] = 'watched by ' + knok_knok[2].to_s
    knok_knok[3] = knok_knok[3].to_s + ' stars'
    knok_knok[4] = knok_knok[4].to_s + ' forks'
    knok_knok[5] = knok_knok[5].to_s + ' contributors'
    knok_knok[6] = knok_knok[6].to_s + ' issues'
  end

  num = options[:number] # display top of some number
  if !num.nil? # rubocop:disable Style/ConditionalAssignment
    table = Terminal::Table.new rows: uganda[0..num.to_i - 1]
  else
    table = Terminal::Table.new rows: uganda
  end
  puts table
end
