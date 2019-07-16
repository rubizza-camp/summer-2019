require_relative 'scanner/shell'
require_relative 'scanner/yaml'
require_relative 'parser/repo'
require_relative 'rating'
require_relative 'printer'

# Scan input atributes from shell
args = Scanner::Shell.new(ARGV).scan
# Get gem list from local file by input attributes
gem_names = Scanner::Yaml.new(args[:file]).scan
return puts "Can't find any gems" if gem_names.empty?

# Filter gem names from file by --name value from shell
names_to_parse = args[:name] ? gem_names.select { |name| name.include?(args[:name]) } : gem_names

# Collect array of gem repo data that we could find
parse_result = names_to_parse.map { |name| Parser::Repo.new(name).parse }.compact

puts('Nothing found') && exit if parse_result.empty?

parsed_gems = parse_result.map { |data| RubyGem.new(data) }

# Sort gems by score desc
rated_gems = Rating.new(parsed_gems).rate

# Get top N gems, if
gems_to_print = args['top'] ? rated_gems.first(args['top']) : rated_gems

# Print sorted arr
Printer.print_gems(gems_to_print)
