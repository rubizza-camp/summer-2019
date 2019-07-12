#!/usr/bin/env ruby

require_relative 'scanner/shell'
require_relative 'scanner/file'
require_relative 'parser/ruby_gems'
require_relative 'parser/git_hub'
require_relative 'ruby_gem'
require_relative 'rating'
require_relative 'printer'

rating_args = Scanner::Shell.new.scan(ARGV)
p rating_args