#!/usr/bin/env ruby

require_relative 'scanner/shell'
require_relative 'scanner/yaml'
require_relative 'parser/ruby_gems'
require_relative 'parser/git_hub'
require_relative 'ruby_gem'
require_relative 'rating'
require_relative 'printer'

rating_args = Scanner::Shell.new(ARGV).scan
gem_names = Scanner::Yaml.new(rating_args['file']).scan
p gem_names