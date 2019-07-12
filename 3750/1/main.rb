require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative 'gemy'

def read_file(array)
  File.open('/home/alexander/summer-2019/3750/1/gems.yaml', 'r') do |f|
    f.each_line do |line|
      next if line.chomp == 'gems:'
      array << Gemy.new(line.strip[2..-1])
    end
  end
end

def average(arr, key)
  sum = 0
  arr.each do |gem|
    sum += (gem.stats[key].delete!',').to_f
  end
  sum / arr.size
end

def calculate_average(arr_of_gems)
  average_stats = {
    average_used:          average(arr_of_gems, :used),
    average_forks:         average(arr_of_gems, :forks),
    average_stars:         average(arr_of_gems, :stars),
    average_contributors:  average(arr_of_gems, :contributors),
    average_watched:       average(arr_of_gems, :watched),
    average_issues:        average(arr_of_gems, :issues)
  }
  p average_stats
end

def calculate_overall_score

end

def show_gems(gems_array)
  gems_array.each do |gem|
    gem.get_stats
    puts '--------------------------------------------------------------------------'
    puts "#{gem.gem_name} |"
    puts '----------------'
    puts "used by #{gem.stats[:used]} repositories"
    puts 'stars - ' + gem.stats[:stars]
    puts 'times watched - ' + gem.stats[:watched]
    puts 'number of forks - ' + gem.stats[:forks]
    puts 'contributors - ' + gem.stats[:contributors]
    puts 'number of issues - ' + gem.stats[:issues]
  end
end

gems = []
read_file(gems)
show_gems(gems)
calculate_average(gems)

