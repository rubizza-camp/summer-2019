#!/usr/bin/env ruby

require_relative 'scanner/shell'
require_relative 'scanner/yaml'
require_relative 'parser/ruby_gems'
require_relative 'parser/git_hub'
require_relative 'ruby_gem'
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
  
  # gem_arr = []
  # Сollect information about each repository
  source_code_urls.each do |gem_name, source_url|
    print gem_name + "\t => " + source_url + "\n\r"
  end
end
