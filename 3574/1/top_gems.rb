require 'httparty'
require 'optparse'
require 'nokogiri'
require 'open-uri'
require 'terminal-table'

class GemsTopTable
  gems_from_file = Hash.new
  gems_from_file[:file_name] = 'list_gems.yaml'

  OptionParser.new do |opts|
    opts.on('--top NUMBER') { |opt| gems_from_file[:number] = opt }
    opts.on('--name WORD') { |opt| gems_from_file[:word] = opt }
    opts.on('--file FILE') { |opt| gems_from_file[:file_name] = opt }
  end.parse!

  names = Array.new
  filename = gems_from_file[:file_name]
  file_content = File.open filename
  file_content.each do |line|
    names.push line.gsub(' - ', '').gsub("\n", '')
  end
  file_content.close
  names.shift

  gem_spec = Array.new
  names.each do |name_id|
    link = HTTParty.get("https://api.github.com/search/repositories?q=#{name_id}")
    git_api = link['items'].first
    gem_stat = Array.new

    gem_stat << name_id

    #used_by
    nokogiri = Nokogiri::HTML(URI.open("#{git_api['html_url']}/network/dependents"))
    parse_element = nokogiri.css('div.table-list-header-toggle > a.btn-link')
    gem_stat << parse_element.first.text.gsub(',', '').to_i

    # watch
    nokogiri = Nokogiri::HTML(URI.open(git_api['html_url']))
    parse_element = nokogiri.css('ul.pagehead-actions > li > a.social-count')
    gem_stat << parse_element.first.text.gsub(',', '').to_i

    gem_stat << git_api['stargazers_count']

    gem_stat << git_api['forks']

    # contributors
    parse_element = nokogiri.css('ul.numbers-summary > li > a > span.num')
    gem_stat << parse_element.last.text.gsub(',', '').to_i

    gem_stat << git_api['open_issues_count']

    gem_spec << gem_stat
  end

  gem_spec.sort! { |first, second| second[1] <=> first[1] }

  gem_spec.delete([])
  gem_spec.each do |table|
    table[1] = 'used by ' + table[1].to_s
    table[2] = 'watched by ' + table[2].to_s
    table[3] = table[3].to_s + ' stars'
    table[4] = table[4].to_s + ' forks'
    table[5] = table[5].to_s + ' contributors'
    table[6] = table[6].to_s + ' issues'
  end

  amount = gems_from_file[:number]
  if !amount.nil? and !amount.empty?
    puts amount
    table = Terminal::Table.new rows: gem_spec[0...amount.to_i]
  else
    table = Terminal::Table.new rows: gem_spec
  end

  puts table
end
