require 'yaml'
require 'terminal-table'
require 'optparse'
require_relative 'repository'
require_relative 'gem_info'

HEADINGS = %w[Name Used\ by Watched\ by Star Forks Contributors Issues].freeze

@command_line = {}

OptionParser.new do |option|
  option.on('--top NUMBER') { |i| @command_line[:number] = i }
  option.on('--name NAME') { |i| @command_line[:name] = i }
  option.on('--file FILE') { |i| @command_line[:file_name] = i }
end.parse!

# filename = if @command_line[:file_name]
#              @command_line[:file_name]
#            else
#              'gems.yml'
#            end

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

# :reek:TooManyStatements
def find_all_gems(gem_list)
  threads = []
  gem_list.each do |gem|
    if (gem_name = @command_line[:name])
      next unless gem.include?(gem_name)
    end
    threads << Thread.new { find_gem(gem) }
  end
  threads.each(&:join)
end

# :reek:UtilityFunction
def add_row_to_table(gems, row, number)
  gems[0...number].each { |gem| row.add_row gem.output }
end

def print_table(gems, number)
  table = Terminal::Table.new do |row|
    add_row_to_table(gems, row, number)
  end

  table.title = 'Gems statistics'
  # table.headings = ['Name', 'Used by', 'Watched by', 'Star', 'Forks', 'Contributors', 'Issues']
  table.headings = HEADINGS
  puts table
end

def sorted_gems(gems)
  gems.sort! { |first, second| second.score <=> first.score }

  # number = if @command_line[:number]
  #            @command_line[:number].to_i
  #          else
  #            gems.length
  #          end

  number = @command_line[:number] ? @command_line[:number].to_i : gems.length

  print_table(gems, number)
end

find_all_gems(gem_list)
sorted_gems(@gems)
