require 'yaml'
require 'optparse'
require_relative 'repository'
require_relative 'gem_info'
require_relative 'table'

@command_line = {}

OptionParser.new do |option|
  option.on('--top NUMBER') { |i| @command_line[:number] = i }
  option.on('--name NAME') { |i| @command_line[:name] = i }
  option.on('--file FILE') { |i| @command_line[:file_name] = i }
end.parse!

filename = @command_line[:file_name] || 'gems.yml'

gem_list = YAML.load_file(filename).dig('gems')
@gems = []

def find_gem(name)
  return unless Repository.a_gem?(name)
  url = Repository.find_github_url(name)
  gem = GemInfo.new(name, url)
  gem.calculate_score
  @gems << gem
end

def create_thread(gem)
  Thread.new { find_gem(gem) }
end

def find_all_gems(gem_list)
  threads = []
  gem_list.each do |gem|
    if (gem_name = @command_line[:name])
      next unless gem.include?(gem_name)
    end
    threads << create_thread(gem)
  end
  threads.each(&:join)
end

def sorted_gems(gems)
  gems.sort! { |first, second| second.score <=> first.score }

  number = @command_line[:number] ? @command_line[:number].to_i : gems.length

  Table.print_table(gems, number)
end

find_all_gems(gem_list)
sorted_gems(@gems)
