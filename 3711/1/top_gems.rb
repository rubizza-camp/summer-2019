require_relative 'scanner/shell'
require_relative 'scanner/yaml'
require_relative 'parser/repo'
require_relative 'rating'
require_relative 'printer'

args = Scanner::Shell.new.scan

gem_names = Scanner::Yaml.new(args[:file]).scan
return puts "Can't find any gems" if gem_names.empty?

names_to_parse = args[:name] ? gem_names.select { |name| name.include?(args[:name]) } : gem_names

parse_result = names_to_parse.map { |name| Parser::Repo.new(name).parse }.compact
puts('Nothing found') && exit if parse_result.empty?

parsed_gems = parse_result.map { |data| RubyGem.new(data) }

rated_gems = Rating.new(parsed_gems).rate

gems_to_print = args[:top] ? rated_gems.first(args[:top].to_i) : rated_gems
Printer.print_gems(gems_to_print)
