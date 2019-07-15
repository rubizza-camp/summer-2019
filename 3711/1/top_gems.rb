require_relative 'scanner/shell'
require_relative 'scanner/yaml'
require_relative 'parser/ruby_gems'
require_relative 'parser/git_hub'
require_relative 'rating'
require_relative 'printer'

# Scan input atributes from shell
rating_args = Scanner::Shell.new(ARGV).scan

# Get gem list from local file by input attributes
gem_names = Scanner::Yaml.new(rating_args).scan
puts "Can't find any gems" if gem_names.size.zero?

unless gem_names.size.zero?
  # Get gem source_code link from RubyGems.org
  source_code_urls = Parser::RubyGems.new(gem_names).parse

  gem_arr = []
  # Collect information about each repository
  source_code_urls.each do |gem_name, source_url|
    # Get gem stats from GitHub repo and write it to RubyGem object instance
    gem_arr << Parser::GitHub.new(gem_name, source_url).parse
  end

  # Sort gems by score desc
  gem_arr = Rating.sort_gems_arr_by_score(gem_arr)

  # Get top N gems, if
  gem_arr = gem_arr.first(rating_args['top'].to_i) unless rating_args['top'].nil?

  # Print sorted arr
  Printer.print_gems(gem_arr)
end
