require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'optparse'
require 'terminal-table'
require_relative 'gemy'
require_relative 'score'
require_relative 'statistics'

def read_file_into_array(array)
  File.open("#{Dir.pwd}/gems.yaml", 'r') do |file|
    file.each_line do |line|
      next if line.chomp == 'gems:'
      array << Gemy.new(line.strip[2..-1]) # [2..-1] gets rid of those '- ' before actual gem name
      # i'm using this instead of delete '- ' because it does not work in cases like '- rspec-core'
    end
  end
end

def calculate_all_data(array_of_gems)
  read_file_into_array(array_of_gems)

  statistic = Statistics.new(array_of_gems)
  statistic.load_stats

  scores = Score.new(array_of_gems)
  scores.calculate_overall_score

  array_of_gems.sort! { |a_gem, b_gem| b_gem.overall_score <=> a_gem.overall_score }
end

def show_gems(gems, top_number = gems.size, name = '')
  rows = []
  table = Terminal::Table.new headings: ["Gem\nname", 'used by', 'watched by', 'stars', 'forks', 'contributors', 'issues']
  top_number.times do |count|
    next unless gems[count].gem_name.include? name
    rows[count] = [gems[count].gem_name, gems[count].stats[:used], gems[count].stats[:watched]]
    rows[count] += [gems[count].stats[:stars], gems[count].stats[:forks]]
    rows[count] += [gems[count].stats[:contributors], gems[count].stats[:issues]]
  end
  table.rows = rows
  puts "Top gems with word '#{name}' in it:" unless name.empty?
  puts "Top #{top_number} gems:" if name.empty?
  puts table
end

# ------------------------------------------------------------------------

options = {
  file_name:   nil,
  top_number: nil,
  name:        nil
}

gems = []

OptionParser.new do |parser|
  parser.on('--file=file_name') do |file_name|
    options[:file_name] = file_name
    puts "Path to directory of gems list is:\n" + Dir.pwd + '/gems.yaml'
    puts "\nfile contents:\n"
    system('cat', Dir.pwd + '/gems.yaml')
    exit
  end
  parser.on('--top=number') do |number|
    options[:top_number] = number.to_i
  end
  parser.on('--name=gem_name') do |gem_name|
    options[:name] = gem_name
  end
end.parse!

calculate_all_data(gems)

show_gems(gems) if options.each_value(&:nil?)
show_gems(gems, options[:top_number], options[:name])
